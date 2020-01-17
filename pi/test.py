#!/usr/bin/env python
import os

import sys, tty, termios
fd = sys.stdin.fileno()
old_settings = termios.tcgetattr(fd)
def getch():
    try:
        tty.setraw(sys.stdin.fileno())
        ch = sys.stdin.read(1)
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
    return ch

from dynamixel_sdk import *

# Control table address
ADDR_MX_TORQUE_ENABLE      = 24
ADDR_MX_GOAL_POSITION      = 30
ADDR_MX_PRESENT_POSITION   = 36

# Protocol version
PROTOCOL_VERSION            = 1.0               # See which protocol version is used in the Dynamixel

# Default setting
numdxl                      = 2;
#DXL_ID                      = 0        
BAUDRATE                    = 115200 #1000000           
DEVICENAME                  = '/dev/ttyUSB0'   

# Initialize PortHandler instance
portHandler = PortHandler(DEVICENAME)

# Initialize PacketHandler instance
# Set the protocol version
# Get methods and members of Protocol1PacketHandler or Protocol2PacketHandler
packetHandler = PacketHandler(PROTOCOL_VERSION)

#gbr = GroupBulkRead(portHandler, packetHandler)

# Open port
if portHandler.openPort():
    print("Succeeded to open the port")
else:
    print("Failed to open the port")
    print("Press any key to terminate...")
    getch()
    quit()

# Set port baudrate
if portHandler.setBaudRate(BAUDRATE):
    print("Succeeded to change the baudrate")
else:
    print("Failed to change the baudrate")
    print("Press any key to terminate...")
    getch()
    quit()

# Enable Dynamixel Torque
for i in range(0,numdxl):
    dxl_comm_result, dxl_error = packetHandler.write1ByteTxRx(portHandler, i, ADDR_MX_TORQUE_ENABLE, 1)
    if dxl_comm_result != COMM_SUCCESS:
        print("%s" % packetHandler.getTxRxResult(dxl_comm_result))
    elif dxl_error != 0:
        print("%s" % packetHandler.getRxPacketError(dxl_error))
    else:
        print("Dynamixel ID " + str(i) + " Torque has been enabled.")

while 1:
    print("Press any key to continue! (or press ESC to quit!)")
    if getch() == chr(0x1b):
        break
    dxl_comm_result, dxl_error = packetHandler.write4ByteTxRx(portHandler, 0, 30, 100)
    print(packetHandler.read4ByteTxRx(portHandler, 0, 36))
    dxl_comm_result, dxl_error = packetHandler.write4ByteTxRx(portHandler, 1, 30, 100)
    print(packetHandler.read4ByteTxRx(portHandler, 1, 36))

# Disable Dynamixel Torque
for i in range(0,numdxl):
    dxl_comm_result, dxl_error = packetHandler.write1ByteTxRx(portHandler, i, ADDR_MX_TORQUE_ENABLE, 0)
    if dxl_comm_result != COMM_SUCCESS:
        print("%s" % packetHandler.getTxRxResult(dxl_comm_result))
    elif dxl_error != 0:
        print("%s" % packetHandler.getRxPacketError(dxl_error))
    else:
        print("Dynamixel ID " + str(i) + " Torque has been disabled.")

# Close port
portHandler.closePort()


'''
# print device id
    deviceID, dxl_comm_result, dxl_error =  packetHandler.read1ByteTxRx(portHandler, 1, 3)

    if dxl_comm_result != COMM_SUCCESS:
        print("%s" % packetHandler.getTxRxResult(dxl_comm_result))
    elif dxl_error != 0:
        print("%s" % packetHandler.getRxPacketError(dxl_error))

    print(deviceID)
'''
