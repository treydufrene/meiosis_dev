#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""basic readable servo commands"""

from dynamixel_sdk import *

# Control table addresses
ADDR_MX_TORQUE_ENABLE      = 24
ADDR_MX_GOAL_POSITION      = 30
ADDR_MX_PRESENT_POSITION   = 36

# Protocol version
PROTOCOL_VERSION            = 1.0

# Default setting
numdxl                      = 1;
BAUDRATE                    = 115200
DEVICENAME                  = '/dev/ttyUSB1'

# Initialize PortHandler instance
portHandler = PortHandler(DEVICENAME)
# Initialize PacketHandler instance
packetHandler = PacketHandler(PROTOCOL_VERSION)

class Servo:
    def __init__(self):
        self.data = []
        #self.initialize()

    def initialize(self):
        # Open port
        if portHandler.openPort():
            print("Succeeded to open the port")
        else:
            print("Failed to open the port")
            quit()
        # Set port baudrate
        if portHandler.setBaudRate(BAUDRATE):
            print("Succeeded to change the baudrate")
        else:
            print("Failed to change the baudrate")
            quit()

        # Enable Dynamixel Torque
        for i in range(0, numdxl):
            dxl_comm_result, dxl_error = packetHandler.write1ByteTxRx(portHandler, i, ADDR_MX_TORQUE_ENABLE, 1)
            if dxl_comm_result != COMM_SUCCESS:
                print("%s" % packetHandler.getTxRxResult(dxl_comm_result))
            elif dxl_error != 0:
                print("%s" % packetHandler.getRxPacketError(dxl_error))
            else:
                print("Dynamixel ID " + str(i) + " Torque has been enabled.")

    def close(self):
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

    def getPos(self, ID):
        return packetHandler.read4ByteTxRx(portHandler, ID, ADDR_MX_PRESENT_POSITION)[0]

    def goTo(self, ID, pos):
        dxl_comm_result, dxl_error = packetHandler.write4ByteTxRx(portHandler, ID, ADDR_MX_GOAL_POSITION, pos)

    def setVel(self, ID, vel):
        dxl_comm_result, dxl_error = packetHandler.write4ByteTxRx(portHandler, ID, 32, vel)



