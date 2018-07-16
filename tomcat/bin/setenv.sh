JAVA_OPTS="-Xms256m -Xmx1024m -XX:PermSize=128m -XX:MaxPermSize=256m -Djava.awt.headless=true -Dfile.encoding=utf-8"
JAVA_OPTS="$JAVA_OPTS -XX:+UseConcMarkSweepGC -Dlog4j.configuration=file://$CATALINA_HOME/conf/log4j.properties"
CATALINA_PID=$CATALINA_HOME/bin/catalina.pid
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CATALINA_HOME/lib/sigar
