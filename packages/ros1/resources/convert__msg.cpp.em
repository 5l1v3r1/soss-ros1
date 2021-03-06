// generated from soss/cpp/ros1/resource/soss__ros1__message.cpp.em
// generated code does not contain a copyright notice

@#######################################################################
@# EmPy template for generating soss/genmsg/ros1/<package>/src/msg/convert__msg__<msg>.cpp files
@#
@# Context:
@#  - spec (genmsg.MsgSpec)
@#    Parsed specification of the .msg file
@#  - subfolder (string)
@#    The subfolder / subnamespace of the message
@#    Either 'msg' or 'srv'
@#  - package (string)
@#    The name of the package
@#  - type (string)
@#    The name of the message type (not including the package name prefix)
@#######################################################################

@{
namespace_parts = ['convert', package, 'msg', type]
namespace_variable = '__'.join(namespace_parts)

conversion_dependency = 'soss/genmsg/ros1/{}/msg/convert__msg__{}.hpp'.format(
    package, type)
}@

// Include the API header for this message type
#include <@(conversion_dependency)>

// Include the Factory header so we can add this message type to the Factory
#include <soss/ros1/Factory.hpp>

// Include the NodeHandle API so we can subscribe and advertise
#include <ros/node_handle.h>

namespace soss {
namespace ros1 {
namespace @(namespace_variable) {

//==============================================================================
class Subscription final
{
public:

  Subscription(
      ros::NodeHandle& node,
      const std::string& topic_name,
      TopicSubscriberSystem::SubscriptionCallback callback,
      uint32_t queue_size,
      const ros::TransportHints& transport_hints)
    : _callback(std::move(callback))
  {
    _message = initialize();

    _subscription = node.subscribe(
        topic_name, queue_size, &Subscription::subscription_callback, this,
        transport_hints);
  }

private:

  void subscription_callback(const Ros1_MsgPtr& msg)
  {
    convert_to_soss(*msg, _message);
    _callback(_message);
  }

  const std::string _topic;

  TopicSubscriberSystem::SubscriptionCallback _callback;

  soss::Message _message;

  ros::Subscriber _subscription;
};

//==============================================================================
std::shared_ptr<void> subscribe(
    ros::NodeHandle& node,
    const std::string& topic_name,
    TopicSubscriberSystem::SubscriptionCallback callback,
    const uint32_t queue_size,
    const ros::TransportHints& transport_hints)
{
  return std::make_shared<Subscription>(
        node, topic_name, std::move(callback), queue_size, transport_hints);
}

//==============================================================================
namespace {
SubscriptionFactoryRegistrar register_subscriber(g_msg_name, &subscribe);
} // anonymous namespace

//==============================================================================
class Publisher final : public virtual soss::TopicPublisher
{
public:

  Publisher(
      ros::NodeHandle& node,
      const std::string& topic_name,
      uint32_t queue_size,
      bool latch)
  {
    _publisher = node.advertise<Ros1_Msg>(topic_name, queue_size, latch);
  }

  bool publish(const soss::Message& message) override
  {
    Ros1_Msg ros1_msg;
    convert_to_ros1(message, ros1_msg);

    _publisher.publish(ros1_msg);
    return true;
  }

private:

  ros::Publisher _publisher;
};

//==============================================================================
std::shared_ptr<soss::TopicPublisher> make_publisher(
    ros::NodeHandle& node,
    const std::string& topic_name,
    const uint32_t queue_size,
    const bool latch)
{
  return std::make_shared<Publisher>(node, topic_name, queue_size, latch);
}

namespace {
PublisherFactoryRegistrar register_publisher(g_msg_name, &make_publisher);
}

} // namespace @(namespace_variable)
} // namespace ros1
} // namespace soss
