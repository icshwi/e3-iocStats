# This makefile is only valid for COMMUNITY Tag 2.9  with > EPICS BASE 3.15.4 
#
# (LOCAL) EPICS_MODULE_SRC_PATH in configure/CONFIG

EXCLUDE_ARCHS += eldk
STARTUPS=-none-
EXCLUDE_VERSIONS=3.14


PCIAPP:= $(EPICS_MODULE_SRC_PATH)/pciApp

HEADERS += $(PCIAPP)/devLibPCI.h
HEADERS += $(PCIAPP)/devLibPCIImpl.h

SOURCES += $(wildcard $(PCIAPP)/devLib*.c)
SOURCES += $(PCIAPP)/pcish.c
SOURCES_Linux += $(PCIAPP)/os/Linux/devLibPCIOSD.c

DBDS += $(PCIAPP)/epicspci.dbd


VMEAPP:= $(EPICS_MODULE_SRC_PATH)/vmeApp

HEADERS += $(VMEAPP)/devcsr.h
HEADERS += $(VMEAPP)/vmedefs.h

SOURCES += $(VMEAPP)/devcsr.c
SOURCES += $(VMEAPP)/iocreg.c
SOURCES += $(VMEAPP)/vmesh.c
SOURCES += $(VMEAPP)/devlib_compat.c

DBDS    += $(VMEAPP)/epicsvme.dbd


where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
include ${where_am_I}/../m-epics-environment/scripts/module.Makefile
#include ${EPICS_ENV_PATH}/module.Makefile
