## site.pp ##

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# Disable filebucket by default for all File resources:
File { backup => false }

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
}

site {
    #Instantiate your corp_website and give it a name
    corp_website { 'corp_website':
    #Our application has one input parameter: the number of web servers in our application
    number_webs => 2,
    number_lbs => 2,
    nodes => {
      #Bind your puppet nodes to the correct component
      Node['web01.cert.test.local'] => [Corp_website::Web['corp_website-web-0']],
      Node['web02.cert.test.local'] => [Corp_website::Web['corp_website-web-1']],
      Node['lb01.cert.test.local'] => [Corp_website::Lb['corp_website-lb-0']],
      Node['lb02.cert.test.local'] => [Corp_website::Lb['corp_website-lb-1']],
      Node['db01.cert.test.local'] => [Corp_website::Db['corp_website']],
    }
  }
}