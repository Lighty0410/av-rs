#!/usr/bin/env bash

# output variables:
# XCODER_AUTO_HEADERS_H: the auto generated header file.
# XCODER_AUTO_SIGNATURE_H: the auto generated signature header file based on
# user supplied signature file

XCODER_AUTO_HEADERS_H="${XCODER_OBJS}/xcoder_auto_headers.h"
XCODER_SIG_FILE="ni_session_sign"
XCODER_AUTO_SIGNATURE_H="${XCODER_OBJS}/xcoder_signature_headers.h"

# write user options to headers
echo "// auto generated by configure" > $XCODER_AUTO_HEADERS_H
echo "#ifndef XCODER_AUTO_HEADER_HPP" >> $XCODER_AUTO_HEADERS_H
echo "#define XCODER_AUTO_HEADER_HPP" >> $XCODER_AUTO_HEADERS_H
echo "" >> $XCODER_AUTO_HEADERS_H
echo "" >> $XCODER_AUTO_HEADERS_H

echo "#define XCODER_AUTO_BUILD_TS \"`date +%s`\"" >> $XCODER_AUTO_HEADERS_H
echo "#define XCODER_AUTO_BUILD_DATE \"`date \"+%Y-%m-%d %H:%M:%S\"`\"" >> $XCODER_AUTO_HEADERS_H
echo "#define XCODER_AUTO_UNAME \"`uname -a`\"" >> $XCODER_AUTO_HEADERS_H
echo "#define XCODER_AUTO_USER_CONFIGURE \"${XCODER_AUTO_USER_CONFIGURE}\"" >> $XCODER_AUTO_HEADERS_H
echo "#define XCODER_AUTO_CONFIGURE \"${XCODER_AUTO_CONFIGURE}\"" >> $XCODER_AUTO_HEADERS_H

echo "" >> $XCODER_AUTO_HEADERS_H
echo "" >> $XCODER_AUTO_HEADERS_H


#####################################################################################
# generate auto headers file, depends on the finished of options.sh
#####################################################################################
# write to source file

if [ $XCODER_TRACELOG_TIMESTAMPS = YES ]; then
    echo "#define NI_LOG_TRACE_TIMESTAMPS" >> $XCODER_AUTO_HEADERS_H
else
    echo "#undef NI_LOG_TRACE_TIMESTAMPS" >> $XCODER_AUTO_HEADERS_H
fi

if [ $XCODER_LINUX_VIRT_IO_DRIVER = YES ]; then
    echo "#define XCODER_LINUX_VIRTIO_DRIVER_ENABLED" >> $XCODER_AUTO_HEADERS_H
else
    echo "#undef XCODER_LINUX_VIRTIO_DRIVER_ENABLED" >> $XCODER_AUTO_HEADERS_H
fi

#if [ $XCODER_WIN32 = YES ]; then
#    echo "#define _WIN32" >> $XCODER_AUTO_HEADERS_H
#else
#    echo "#undef _WIN32" >> $XCODER_AUTO_HEADERS_H
#fi

if [ $XCODER_ENCODER_SYNC_QUERY = YES ]; then
    echo "#define ENCODER_SYNC_QUERY" >> $XCODER_AUTO_HEADERS_H
else
    echo "#undef ENCODER_SYNC_QUERY" >> $XCODER_AUTO_HEADERS_H
fi

if [ $XCODER_SELF_KILL_ERR = YES ]; then
    echo "#define XCODER_SELF_KILL_ERR" >> $XCODER_AUTO_HEADERS_H
else
    echo "#undef XCODER_SELF_KILL_ERR" >> $XCODER_AUTO_HEADERS_H
fi

if [ $XCODER_LATENCY_DISPLAY = YES ]; then
    echo "#define MEASURE_LATENCY" >> $XCODER_AUTO_HEADERS_H
else
    echo "#undef MEASURE_LATENCY" >> $XCODER_AUTO_HEADERS_H
fi

echo "" >> $XCODER_AUTO_HEADERS_H

###############################################################################
# generate auto signature header file
###############################################################################
if [ $XCODER_SIGNATURE_FILE = YES ]; then
    xxd -i $XCODER_SIG_FILE $XCODER_AUTO_SIGNATURE_H
    echo "#define XCODER_SIGNATURE_FILE " >> $XCODER_AUTO_HEADERS_H
else
    echo "#undef XCODER_SIGNATURE_FILE" >> $XCODER_AUTO_HEADERS_H
fi

# auto header EOF.
echo "#endif" >> $XCODER_AUTO_HEADERS_H
echo "" >> $XCODER_AUTO_HEADERS_H
