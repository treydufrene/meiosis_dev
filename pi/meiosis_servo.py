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
numdxl                      = 2;
BAUDRATE                    = 115200
DEVICENAME                  = '/dev/ttyUSB0'

gearidx = [(-39.0)*(128.0/45.0), (-39.0)*(128.0/45.0)]
offset = [0,0]

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
        return packetHandler.read2ByteTxRx(portHandler, ID, ADDR_MX_PRESENT_POSITION)[0]

    def setPos(self, ID, pos):
        dxl_comm_result, dxl_error = packetHandler.write2ByteTxRx(portHandler, ID, ADDR_MX_GOAL_POSITION, pos)
        #print(dxl_comm_result, dxl_error)

    def setVel(self, ID, vel):
        dxl_comm_result, dxl_error = packetHandler.write2ByteTxRx(portHandler, ID, 32, vel)
    
    def moving(self, ID):
        return packetHandler.read1ByteTxRx(portHandler, ID, 46)[0]

    def anyMoving(self, IDLIST):
        statusidx = [0,0]
        for i in range(0,len(IDLIST)):
            statusidx[i] = self.moving(IDLIST[0])
        return any(statusidx)

    def setRes(self, ID, res):
        dxl_comm_result, dxl_error = packetHandler.write1ByteTxRx(portHandler, ID, 22, res)

    def readRes(self, ID):
        return packetHandler.read1ByteTxRx(portHandler, ID, 22)[0]

    def disableTorque(self, ID):
        dxl_comm_result, dxl_error = packetHandler.write1ByteTxRx(portHandler, ID, ADDR_MX_TORQUE_ENABLE, 0)
    
    def enableTorque(self, ID):
        dxl_comm_result, dxl_error = packetHandler.write1ByteTxRx(portHandler, ID, ADDR_MX_TORQUE_ENABLE, 1)

    def setMultiturn(self, ID, on):
        if(on):
            dxl_comm_result, dxl_error = packetHandler.write2ByteTxRx(portHandler, ID, 6, 4095)
            dxl_comm_result, dxl_error = packetHandler.write2ByteTxRx(portHandler, ID, 8, 4095)
        else:
            dxl_comm_result, dxl_error = packetHandler.write2ByteTxRx(portHandler, ID, 6, 0)
            dxl_comm_result, dxl_error = packetHandler.write2ByteTxRx(portHandler, ID, 8, 4095)

    def setJA(self, IDLIST, angle):
        if(type(IDLIST) == int):
            IDLIST = [IDLIST]
        if(type(angle) == int):
            angle = [angle]
        for i in range(0,len(IDLIST)):
            self.setPos(IDLIST[i], int(round(angle[i] * gearidx[i] + offset[i])))
            print(int(round(angle[i] * gearidx[i] + offset[i])))

    def setOffset(self, ID, amount):
        offset[ID] = amount
        dxl_comm_result, dxl_error = packetHandler.write2ByteTxRx(portHandler, ID, 20, amount)
        return offset[ID]


