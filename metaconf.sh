#!/bin/bash
SRCS="/usr/local/ALM/staging"
SRCD="/usr/local/SATcopy/prod/dist"
DSTM="/opt/shibboleth-idp/metadata"
DSTC="/opt/shibboleth-idp/conf"
# log location
LOGBASE=/root/logs/metadata-deployment.$(date +%F.%T)
# who to notify
RECIP="emailaddress"
LOG=$LOGBASE.log
ERR=$LOGBASE.err
ERRORS=false
UPDATE=false
cd $SRCS
for i in * ; do
    if [[ $i = *metadata* && $SRCS/$i -nt $DSTM/$i ]]; then
        UPDATE=true
        echo "Initial files:" | tee -a $LOG
        ls -ogl $DSTM/$i 2>&1 | tee -a $LOG
        ls -ogl $SRCS/$i 2>&1 | tee -a $LOG
        echo "Copying..." | tee -a $LOG
        cp -f -v --preserve=timestamps $SRCS/$i $DSTM 2>&1 | tee -a $LOG
        if [ $PIPESTATUS -ne 0 ] ; then
            ERRORS=true
            echo "ERROR while copying metadata into place!" | tee -a $LOG $ERR
        fi
        touch $DSTM/$i
        chown tomcat:tomcat $DSTM/$i 2>&1 | tee -a $LOG
        if [ $PIPESTATUS -ne 0 ] ; then
            ERRORS=true
            echo "ERROR while chowning metadata!" | tee -a $LOG $ERR
        fi
        echo "Final files:" | tee -a $LOG
        ls -ogl $DSTM/$i 2>&1 | tee -a $LOG
        ls -ogl $SRCS/$i 2>&1 | tee -a $LOG
    else
        echo "$i file unchanged"
    fi
done
if $UPDATE ; then
    echo "$SRCS Metadata deployment completed." | tee -a $LOG ;
fi

UPDATE=false

for i in * ; do
    if [[ $i != *metadata* && $SRCS/$i -nt $DSTC/$i ]]; then
        UPDATE=true
        echo "Initial files:" | tee -a $LOG
        ls -ogl $DSTC/$i 2>&1 | tee -a $LOG
        ls -ogl $SRCS/$i 2>&1 | tee -a $LOG
        echo "Copying..." | tee -a $LOG
        cp -f -v --preserve=timestamps $SRCS/$i $DSTC 2>&1 | tee -a $LOG
        if [ $PIPESTATUS -ne 0 ] ; then
            ERRORS=true
            echo "ERROR while copying conf files into place!" | tee -a $LOG $ERR
        fi
        touch $DSTC/$i
        chown tomcat:tomcat $DSTC/$i 2>&1 | tee -a $LOG
        if [ $PIPESTATUS -ne 0 ] ; then
            ERRORS=true
            echo "ERROR while chowning conf files!" | tee -a $LOG $ERR
        fi
        echo "Final files:" | tee -a $LOG
        ls -ogl $DSTC/$i 2>&1 | tee -a $LOG
        ls -ogl $SRCS/$i 2>&1 | tee -a $LOG
    else
        echo "$i file unchanged"
    fi
done
if $UPDATE ; then
    echo "$SRCS Conf files deployment completed." | tee -a $LOG ;
fi

UPDATE=false

cd $SRCD

for i in * ; do
    if [[ $i = *metadata* && $SRCD/$i -nt $DSTM/$i ]]; then
        UPDATE=true
        echo "Initial files:" | tee -a $LOG
        ls -ogl $DSTM/$i 2>&1 | tee -a $LOG
        ls -ogl $SRCD/$i 2>&1 | tee -a $LOG
        echo "Copying..." | tee -a $LOG
        cp -f -v --preserve=timestamps $SRCD/$i $DSTM 2>&1 | tee -a $LOG
        if [ $PIPESTATUS -ne 0 ] ; then
            ERRORS=true
            echo "ERROR while copying metadata into place!" | tee -a $LOG $ERR
        fi
        touch $DSTM/$i
        chown tomcat:tomcat $DSTM/$i 2>&1 | tee -a $LOG
        if [ $PIPESTATUS -ne 0 ] ; then
            ERRORS=true
            echo "ERROR while chowning metadata!" | tee -a $LOG $ERR
        fi
        echo "Final files:" | tee -a $LOG
        ls -ogl $DSTM/$i 2>&1 | tee -a $LOG
        ls -ogl $SRCD/$i 2>&1 | tee -a $LOG
    else
        echo "$i file unchanged"
    fi
done
if $UPDATE ; then
    echo "$SRCD Metadata deployment completed." | tee -a $LOG ;
fi

UPDATE=false

for i in * ; do
    if [[ $i != *metadata* && $SRCD/$i -nt $DSTC/$i ]]; then
        UPDATE=true
        echo "Initial files:" | tee -a $LOG
        ls -ogl $DSTC/$i 2>&1 | tee -a $LOG
        ls -ogl $SRCD/$i 2>&1 | tee -a $LOG
        echo "Copying..." | tee -a $LOG
        cp -f -v --preserve=timestamps $SRCD/$i $DSTC 2>&1 | tee -a $LOG
        if [ $PIPESTATUS -ne 0 ] ; then
            ERRORS=true
            echo "ERROR while copying conf files into place!" | tee -a $LOG $ERR
        fi
        touch $DSTC/$i
        chown tomcat:tomcat $DSTC/$i 2>&1 | tee -a $LOG
        if [ $PIPESTATUS -ne 0 ] ; then
            ERRORS=true
            echo "ERROR while chowning conf files!" | tee -a $LOG $ERR
        fi
        echo "Final files:" | tee -a $LOG
        ls -ogl $DSTC/$i 2>&1 | tee -a $LOG
        ls -ogl $SRCD/$i 2>&1 | tee -a $LOG
    else
        echo "$i file unchanged"
    fi
done
if $UPDATE ; then
    echo "$SRCD Conf files deployment completed." | tee -a $LOG ;
fi

if [ -e $LOG ]; then
    mail -s "$(hostname -s) Shib files deployed -- $(date)" $RECIP < $LOG
fi

exit
