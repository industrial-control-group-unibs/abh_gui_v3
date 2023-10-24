
from signal import signal, SIGINT
from python_binary_udp_helper import UdpBinarySenderThread, UdpBinaryReceiverThread
import sys
import socket
import time
import logging
from threading import Thread
import Colorer
import pandas as pd
import abh_constants as abh
import minimalmodbus
import getpass
from enum import Enum



class Status(Enum):
    REWIRE  = -1
    OFF     =  0
    ON      =  1
    REWIRED =  2

stiffness_cmd=0.2
velocity_cmd=0.2
off=0
stop=False
abs_position=0
fb_velocity=0
state=0
dtorque=0
torque_change_time=0.5

def handler(signal_received, frame):
    global stop
    logging.debug("stop!!")
    stop=True


def comunicationThread():
    global stop
    global stiffness_cmd
    global velocity_cmd
    global off
    global abs_position
    global fb_velocity
    global dtorque
    global torque_change_time
    logging.debug("starting comunication_thread")
    itrial=0

    logging.debug("connecting with motor_target")
    motor_target_client=-1
    motor_feedback=-1
    while (not stop):
        try:
            motor_target_client=UdpBinaryReceiverThread("motor_target",abh.ABH_CONTROL,abh.MOTOR_TARGET_PORT)
            motor_target_client.bufferLength(4)
            motor_target_client.start()
            break
        except:
            if itrial % 60==0:
                logging.debug("waiting for connection with motor target.")
            itrial+=1
            time.sleep(1)
    if (stop):
        logging.info("stopped before connecting with motor_target, tried %d times", itrial)
        logging.info("return before connecting with motor_target")
        return


    logging.info("connected with motor_target")

    logging.debug("creating server for motor_feedback")
    try:
        motor_feedback = UdpBinarySenderThread("motor_feedback",abh.ABH_CONTROL,abh.MOTOR_FEEDBACK_PORT)
    except Exception as e:
        stop=True
        logging.error("unable to create server for motor_feedback")
        motor_target_client.stopThread()
        motor_target_client.join()
        logging.critical(str(e), exc_info=True)  # log exception info at CRITICAL log level

        return
    logging.info("created server for motor_feedback")

    while (not stop):
        while motor_target_client.isNewDataAvailable():
            cmd=motor_target_client.getData()
            off=int(cmd[0])
            stiffness_cmd=min(3,max(0,float(cmd[1])))
            velocity_cmd=min(1,max(0,float(cmd[2])))
            torque_change_time=max(0.01,float(cmd[3]))
            logging.info("received torque_perc = "+ str(stiffness_cmd) + ", velocity_perc = " + str(velocity_cmd) + ", off ="+ str(off) )
        motor_feedback.sendData([abs_position,fb_velocity])

        time.sleep(0.001)

    logging.info("stopping comunicationThread clean")


    if not isinstance(motor_target_client,int):
        motor_target_client.stopThread()
        motor_target_client.join()
    else:
        logging.debug("motor_target_client is off")


    logging.info("stopped comunicationThread clean")


def controlThread():
    global stop
    global stiffness_cmd
    global velocity_cmd
    global off
    global abs_position
    global fb_velocity
    global dtorque
    global torque_change_time
    logging.debug("starting control_thread")

    simulate=False
    PORT='/dev/ttyUSB0'
    VEL_REGISTER = 0x100
    ACC_REGISTER = 0x104
    TOR_REGISTER = 0x102
    MAX_CUR_REGISTER = 0x1011
    ENCODER_VEL_REGISTER = 0x2214
    ENCODER_POS_REGISTER = 0x1002
    DIRECTION_REGISTER = 0x0000
    REAL_CURRENT = 0x1008
    REFERENCE_CURRENT = 0x1013

    read_current = True

    while (not stop):
        try:
            #Set up instrument
            if (not simulate):
                instrument = minimalmodbus.Instrument(PORT,1,mode=minimalmodbus.MODE_RTU)
                #Make the settings explicit
                instrument.serial.baudrate = 57600 # Baud
                instrument.serial.bytesize = 8
                instrument.serial.parity   = minimalmodbus.serial.PARITY_NONE
                instrument.serial.stopbits = 1
                instrument.serial.timeout  = 1          # seconds

                # Good practice
                instrument.close_port_after_each_call = False
                instrument.clear_buffers_before_each_transaction = True

            else:
                instrument = -1
            break

        except Exception as e:
            logging.error("error during connection")
            logging.error(str(e), exc_info=True)  # log exception info at CRITICAL log level
            time.sleep(5.0)


    torque_change_time=0.5

    dt=0.02;
    offset_position=0
    passi_encoder=8192
    passi_motore=65535.0

    torque_min=0
    torque_max=2800

    torque_change_time=1.0
    dtorque=(torque_max-torque_min)/torque_change_time

    saturated_torque=0
    torque0=10
    torque_rewind=800

    vel_min=0
    vel_max=40
    vel_actual=0
    setpoint_vel=0
    vel_rewind =2.0

    last_position=0
    if (not simulate):
        last_position=instrument.read_register(ENCODER_POS_REGISTER)
        instrument.write_float(VEL_REGISTER,0.0)
        instrument.write_float(TOR_REGISTER,0.0)
    time.sleep(3)

    t0=time.time()
    t_state_0=time.time()
    inc_state_0=0.0
    abs_position0=(last_position)*8/pow(2,16)


    state= Status.OFF;
    off=1;
    stiffness_cmd_local=0.00
    vel_actual=0.0

    log_time=time.time()
    log_period=10;

    rest_time = time.time()
    rest_position = 0
    is_rewired = False
    last_abs_position=0

    fb_velocity_raw=0.0

    real_current_value = 0.0
    reference_current_value = 0.0
    while (not stop):
        try:
            tc1 = time.time()

            dtorque=(torque_max-torque_min)/torque_change_time*dt
            if (not simulate):
                position = instrument.read_register(ENCODER_POS_REGISTER)
                real_current_value = instrument.read_register(REAL_CURRENT)
                reference_current_value = instrument.read_register(REFERENCE_CURRENT)
                print(f" real current = {real_current_value}, reference_current = {reference_current_value}")
            else:
                position = last_position+vel_actual*passi_motore/8


            if (last_position-position)>+0.8*pow(2,16):
                offset_position=offset_position+pow(2,16)
            elif (last_position-position)<-0.8*pow(2,16):
                offset_position=offset_position-pow(2,16)
            last_position=position

            abs_position=(position+offset_position)*8/pow(2,16)
            abs_position=abs_position-abs_position0
            fb_velocity_raw=(abs_position-last_abs_position)/dt
            fb_velocity=0.0*fb_velocity+1.0*fb_velocity_raw
            last_abs_position=abs_position
            t=time.time()-t0
            last_time=t

            if (abs(abs_position-rest_position)>0.01):
                rest_position=abs_position
                rest_time = time.time()
            elif (time.time()-rest_time)>3.0:
                if (not is_rewired):
                    logging.info("rewired")
                is_rewired = True



            if (off==1):
                state=Status.OFF
            elif (state!=Status.REWIRE and off==2):
                stop_position=abs_position
                rest_timer=time.time()
                state=Status.REWIRE
                is_rewired=False
            elif (state==Status.REWIRE and is_rewired):
                state=Status.OFF
                abs_position0=abs_position
            elif (state==Status.OFF and off==0):
                state=Status.ON


            stiffness_cmd_local = min(3.0,max(0.0,stiffness_cmd))
            velocity_cmd_local  = min(1.0,max(0.0,velocity_cmd))



            if state==Status.OFF:
                torque     = 0.0
                vel_actual = 0.0
            elif state==Status.REWIRE:
                torque     = torque_rewind
                vel_actual = vel_rewind
            else: # Status.ON
                torque=torque_min + stiffness_cmd_local * (torque_max - torque_min)
                vel_actual = vel_min    + velocity_cmd_local  * (vel_max    - vel_min)

            if ((time.time()-log_time)>log_period):
                log_time=time.time()
                logging.info("tor perc= "+ str(stiffness_cmd_local)+ ", torque = "+ str(torque) + ", velocity = " + str(vel_actual)+ ", pos ="+ str(abs_position))

            if (torque>(saturated_torque+dtorque)):
                saturated_torque+=dtorque
                #print("torque_change_time = ",torque_change_time," dtorque = ",dtorque, " saturated_torque = ",saturated_torque)
            elif (torque<(saturated_torque-dtorque)):
                saturated_torque-=dtorque
                #print("torque_change_time = ",torque_change_time," dtorque = ",dtorque, " saturated_torque = ",saturated_torque)
            else:
                saturated_torque=torque

            if (not simulate):
                instrument.write_float(TOR_REGISTER,saturated_torque)
                instrument.write_float(VEL_REGISTER,vel_actual*passi_motore)

            tc2 = time.time()
            elapsed=(tc2-tc1)
            time.sleep(max(dt-elapsed,0))

        except Exception as e:
            logging.error("control_thread with error")
            logging.error(str(e), exc_info=True)  # log exception info at CRITICAL log level
    if (not simulate):
        instrument.write_float(VEL_REGISTER,0.0)
        instrument.write_float(TOR_REGISTER,0.0)
    logging.debug("stopping controlThread clean")

if __name__ == '__main__':
    # %% initialization
    signal(SIGINT, handler)
    logging.basicConfig(filename='motor_control.log', level=logging.DEBUG, format=' [%(asctime)s,%(filename)s:%(lineno)-4s - %(funcName)20s()] %(levelname)-8s :: %(message)s', filemode='w')
    logger = logging.getLogger(__name__)
    console = logging.StreamHandler()
    console.setFormatter(logging.Formatter(logging.BASIC_FORMAT))
    console.setLevel(logging.INFO)
    logging.getLogger('').addHandler(console)
    time.sleep(5)
    # %% Running thread
    com_thread = Thread(target=comunicationThread, args=())
    com_thread.start()



    ctrl_thread = Thread(target=controlThread, args=())
    ctrl_thread.start()

    com_thread.join()
    ctrl_thread.join()
    #status_thread.join()
    logging.info("return clean")
