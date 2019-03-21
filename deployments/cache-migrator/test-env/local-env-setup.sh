#!/bin/bash
#
# Copyright (C) 2011-2018 Red Hat, Inc. (https://github.com/Commonjava/indy)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


THIS=$(cd ${0%/*} && echo $PWD/${0##*/})
# THIS=`realpath ${0}`
BASEDIR=`dirname ${THIS}`

echo "Starting postgres database..."
docker run --rm -d -p 5432:5432 -e POSTGRES_PASSWORD=test -e POSTGRES_USER=test --name postgres postgres:10 || exit -1

export TEST_ETC=$BASEDIR/indy-env

echo "Clearing local maven repo at /tmp/maven-repo..."
rm -rf /tmp/maven-repo

echo "Starting Indy..."
$BASEDIR/../../../bin/test-setup.sh

echo "Postgres container is STILL RUNNING. When done testing, stop using the command:"
echo "docker stop postgres"
