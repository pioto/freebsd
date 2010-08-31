#-
# Copyright (c) 2009 Nathan Whitehorn
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#
# $FreeBSD$
#

#include <sys/param.h>
#include <sys/lock.h>
#include <sys/mutex.h>
#include <sys/systm.h>

#include <machine/platform.h>
#include <machine/platformvar.h>
#include <machine/smp.h>

/**
 * @defgroup PLATFORM platform - KObj methods for PowerPC platform
 * implementations
 * @brief A set of methods required by all platform implementations.
 * These are used to bring up secondary CPUs, supply the physical memory
 * map, etc.
 *@{
 */

INTERFACE platform;

#
# Default implementations
#
CODE {
	static void platform_null_attach(platform_t plat)
	{
		return;
	}
	static int platform_null_smp_first_cpu(platform_t plat,
	    struct cpuref  *cpuref)
	{
		cpuref->cr_hwref = -1;
		cpuref->cr_cpuid = 0;
		return (0);
	}
	static int platform_null_smp_next_cpu(platform_t plat,
	    struct cpuref  *_cpuref)
	{
		return (ENOENT);
	}
};

/**
 * @brief Probe for whether we are on this platform, returning the standard
 * newbus probe codes. If we have Open Firmware or a flattened device tree,
 * it is guaranteed to be available at this point.
 */
METHOD int probe {
	platform_t	_plat;
};


/**
 * @brief Attach this platform module. This happens before the MMU is online,
 * so the platform module can install its own high-priority MMU module at
 * this point.
 */
METHOD int attach {
	platform_t	_plat;
} DEFAULT platform_null_attach;


/**
 * @brief Return the system's physical memory map.
 * 
 * It shall provide the total and the available regions of RAM.
 * The available regions need not take the kernel into account.
 *
 * @param _memp		Array of physical memory chunks
 * @param _memsz	Number of physical memory chunks
 * @param _availp	Array of available physical memory chunks
 * @param _availsz	Number of available physical memory chunks
 */

METHOD void mem_regions {
	platform_t	    _plat;
	struct mem_region **_memp;
	int		   *_memsz;
	struct mem_region **_availp;
	int		   *_availsz;
};

/**
 * @brief Get the CPU's timebase frequency, in ticks per second.
 *
 * @param _cpu		CPU whose timebase to query
 */

METHOD u_long timebase_freq {
	platform_t	_plat;
	struct cpuref  *_cpu;
};

# SMP bits 

/**
 * @brief Fill the first CPU's cpuref
 *
 * @param _cpuref	CPU
 */
METHOD int smp_first_cpu {
	platform_t	_plat;
	struct cpuref  *_cpuref;
} DEFAULT platform_null_smp_first_cpu;

/**
 * @brief Fill the next CPU's cpuref
 *
 * @param _cpuref	CPU
 */
METHOD int smp_next_cpu {
	platform_t	_plat;
	struct cpuref  *_cpuref;
} DEFAULT platform_null_smp_next_cpu;

/**
 * @brief Find the boot processor
 *
 * @param _cpuref	CPU
 */
METHOD int smp_get_bsp {
	platform_t	_plat;
	struct cpuref  *_cpuref;
} DEFAULT platform_null_smp_first_cpu;

/**
 * @brief Start a CPU
 *
 * @param _cpuref	CPU
 */
METHOD int smp_start_cpu {
	platform_t	_plat;
	struct pcpu	*_cpu;
};

/**
 * @brief Reset system
 */
METHOD void reset {
	platform_t	_plat;
};

