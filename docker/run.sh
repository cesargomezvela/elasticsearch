#!/bin/sh

BASE=/usr/share/elasticsearch

# allow for memlock if enabled
if [ "$MEMORY_LOCK" == "true" ]; then
    ulimit -l unlimited
fi

# Set a random node name if not set.
if [ -z "${NODE_NAME}" ]; then
	NODE_NAME=$(uuidgen)
fi
export NODE_NAME=${NODE_NAME}

# Prevent "Text file busy" errors
sync

if [ ! -z "${ES_PLUGINS_INSTALL}" ]; then
   OLDIFS=$IFS
   IFS=','
   for plugin in ${ES_PLUGINS_INSTALL}; do
      if ! $BASE/bin/elasticsearch-plugin list | grep -qs ${plugin}; then
         yes | $BASE/bin/elasticsearch-plugin install --batch ${plugin}
      fi
   done
   IFS=$OLDIFS
fi

# run
chown -R elasticsearch:elasticsearch $BASE
chown -R elasticsearch:elasticsearch $BASE/data
exec su elasticsearch /usr/local/bin/docker-entrypoint.sh
