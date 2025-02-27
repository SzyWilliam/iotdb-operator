#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

# docker build context is the root path of the repository

FROM openjdk:11-jre-slim

ADD target/apache-iotdb-operator-*.zip /

RUN apt update \
  && apt install vim dos2unix unzip -y \
  && unzip /apache-iotdb-operator-*.zip -d /apache-iotdb-operator \
  && rm /apache-iotdb-operator-*.zip \
  && ls \
  && mv /apache-iotdb-operator /iotdb-operator \
  && apt remove unzip -y \
  && apt autoremove -y \
  && apt purge --auto-remove -y \
  && apt clean -y
RUN dos2unix /iotdb-operator/sbin/start-operator.sh
ENTRYPOINT ["/iotdb-operator/sbin/start-operator.sh"]