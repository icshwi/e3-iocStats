
include $(E3_REQUIRE_TOOLS)/driver.makefile

#include /testing/epics/base-3.15.5/require/0.0.1/tools/driver.makefile

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

DBDS    += $(IOCADMINSRC)/iocAdmin.dbd




TEMPLATES += $(wildcard $(IOCADMINDB)/*.db)
TEMPLATES += $(wildcard $(IOCADMINDB)/*.template)
#TEMPLATES += $(wildcard $(IOCADMINDB)/*.substitutions)





EPICS_BASE_HOST_BIN = $(EPICS_BASE)/bin/$(EPICS_HOST_ARCH)
MSI =  $(EPICS_BASE_HOST_BIN)/msi


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
