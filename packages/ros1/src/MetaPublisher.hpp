/*
 * Copyright (C) 2019 Open Source Robotics Foundation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
*/

#ifndef SOSS__ROS1__SRC__METAPUBLISHER_HPP
#define SOSS__ROS1__SRC__METAPUBLISHER_HPP

#include <soss/SystemHandle.hpp>

#include <ros/node_handle.h>

namespace soss {
namespace ros1 {

//==============================================================================
std::shared_ptr<TopicPublisher> make_meta_publisher(
    const std::string& message_type,
    ros::NodeHandle& node,
    const std::string& topic_name,
    uint32_t queue_size,
    bool latch,
    const YAML::Node& configuration);

} // namespace ros1
} // namespace soss

#endif // SOSS__ROS1__SRC__METAPUBLISHER_HPP
