#
#  Copyright (c) 2017 - Present  Jeong Han Lee
#  Copyright (c) 2017 - Present  European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
# Author  : Jeong Han Lee
# email   : han.lee@esss.se
# Date    : Monday, September 10 09:23:12 CEST 2018
# version : 0.0.4

where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

include $(E3_REQUIRE_TOOLS)/driver.makefile


# *** ISSUES
# driver.makefile recursively read all include directories which were installed.
# The only way to exclude header files is....



#iocStats_VERSION=
autosave_VERSION=
asyn_VERSION=
busy_VERSION=
modbus_VERSION=
ipmiComm_VERSION=
sequencer_VERSION=
sscan_VERSION=

std_VERSION=
ip_VERSION=
calc_VERSION=
pcre_VERSION=
stream_VERSION=
s7plc_VERSION=
recsync_VERSION=

devlib2_VERSION=
mrfioc2_VERSION=

exprtk_VERSION=
motor_VERSION=
ecmc_VERSION=
#EthercatMC_VERSION=
ecmctraining_VERSION=


keypress_VERSION=
sysfs_VERSION=
symbolname_VERSION=
memDisplay_VERSION=
regdev_VERSION=
i2cDev_VERSION=

tosca_VERSION=
tsclib_VERSION=
ifcdaqdrv2_VERSION=

## The main issue is nds3, it is mandatory to disable it
## 
nds3_VERSION=
nds3epics_VERSION=
ifc14edrv_VERSION=
ifcfastint_VERSION=


nds_VERSION=
loki_VERSION=
nds_VERSION=
sis8300drv_VERSION=
sis8300_VERSION=
sis8300llrfdrv_VERSION=
sis8300llrf_VERSION=


ADSupport_VERSION=
ADCore_VERSION=
ADSimDetector_VERSION=
ADAndor_VERSION=
ADAndor3_VERSION=
ADPointGrey_VERSION=
ADProsilica_VERSION=

amcpico8_VERSION=
adpico8_VERSION=
adsis8300_VERSION=
adsis8300bcm_VERSION=
adsis8300bpm_VERSION=
adsis8300fc_VERSION=


USR_CPPFLAGS += -DUSE_TYPED_RSET


DEVIOCSTATS:=devIocStats

HEADERS += $(DEVIOCSTATS)/os/default/devIocStatsOSD.h
HEADERS += $(DEVIOCSTATS)/devIocStats.h


# Original Makefile : OSI parts
# SRCS += devIocStatsAnalog.c
# SRCS += devIocStatsString.c
# SRCS += devIocStatsWaveform.c
# SRCS += devIocStatsSub.c
# SRCS += devIocStatsTest.c


SOURCES += $(DEVIOCSTATS)/devIocStatsAnalog.c
SOURCES += $(DEVIOCSTATS)/devIocStatsString.c
SOURCES += $(DEVIOCSTATS)/devIocStatsWaveform.c
SOURCES += $(DEVIOCSTATS)/devIocStatsSub.c
SOURCES += $(DEVIOCSTATS)/devIocStatsTest.c



# The original makefile : OSD parts
#
# SRCS += osdCpuUsage.c
# SRCS += osdCpuUtilization.c
# SRCS += osdFdUsage.c
# SRCS += osdMemUsage.c
# SRCS += osdWorkspaceUsage.c
# SRCS += osdClustInfo.c
# SRCS += osdSuspTasks.c
# SRCS += osdIFErrors.c
# SRCS += osdBootInfo.c
# SRCS += osdSystemInfo.c
# SRCS += osdHostInfo.c
# SRCS += osdPIDInfo.c

# iocStats has many source codes, which has the same name in
# terms of archtecture. driver.makefile isn't clever enough to
# understand its relations, so we have to use the specific
# source codes order in the same as the original makefile
# as follows:

SOURCES += $(DEVIOCSTATS)/os/Linux/osdCpuUsage.c
SOURCES += $(DEVIOCSTATS)/os/Linux/osdCpuUtilization.c
SOURCES += $(DEVIOCSTATS)/os/Linux/osdFdUsage.c
SOURCES += $(DEVIOCSTATS)/os/Linux/osdMemUsage.c
SOURCES += $(DEVIOCSTATS)/os/default/osdWorkspaceUsage.c
SOURCES += $(DEVIOCSTATS)/os/default/osdClustInfo.c
SOURCES += $(DEVIOCSTATS)/os/default/osdSuspTasks.c
SOURCES += $(DEVIOCSTATS)/os/default/osdIFErrors.c
SOURCES += $(DEVIOCSTATS)/os/default/osdBootInfo.c
SOURCES += $(DEVIOCSTATS)/os/posix/osdSystemInfo.c
SOURCES += $(DEVIOCSTATS)/os/posix/osdHostInfo.c
SOURCES += $(DEVIOCSTATS)/os/posix/osdPIDInfo.c

DBDS    += $(DEVIOCSTATS)/devIocStats.dbd

HEADERS += $(DEVIOCSTATS)/devIocStats.h


IOCADMIN:= iocAdmin
IOCADMINSRC:=$(IOCADMIN)/src
IOCADMINDB:=$(IOCADMIN)/Db

DBDS      += $(IOCADMINSRC)/iocAdmin.dbd

TEMPLATES += $(wildcard $(IOCADMINDB)/*.db)
TEMPLATES += $(wildcard $(IOCADMINDB)/*.template)
#TEMPLATES += $(wildcard $(IOCADMINDB)/*.substitutions)





USR_DBFLAGS += -I . -I ..
USR_DBFLAGS += -I$(EPICS_BASE)/db
USR_DBFLAGS += -I$(IOCADMINDB)


SUBS = $(wildcard $(IOCADMINDB)/*.substitutions)
TEMS = $(wildcard $(IOCADMINDB)/*.template)


db: $(SUBS) $(TEMS)

$(SUBS): 
	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db -S $@  > $(basename $(@)).db.d
	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db -S $@

$(TEMS): 
	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db $@  > $(basename $(@)).db.d
	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db $@




.PHONY: db $(SUBS) $(TEMS) 
