#
#  Copyright (c) 2017 - 2019     Jeong Han Lee
#  Copyright (c) 2017 - 2019     European Spallation Source ERIC
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
# Date    : Wednesday, September 11 20:57:11 CEST 2019
# version : 0.1.1

where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
include $(E3_REQUIRE_TOOLS)/driver.makefile
include $(E3_REQUIRE_CONFIG)/DECOUPLE_FLAGS

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

# Not sure the following file is useful or not
SCRIPTS += $(IOCADMINSRC)/iocReleaseCreateDb.py

# The following DBD contains "devIocStats.dbd", so it is not
# necessary to add it again. 
# DBDS      += $(IOCADMINSRC)/iocAdmin.dbd



SCRIPTS += ../iocsh/iocStats.iocsh


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
#
.PHONY: vlibs
vlibs:
#
