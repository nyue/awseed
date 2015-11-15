import boto3.ec2
# See http://cloud-images.ubuntu.com/releases/12.04.2/release/
default_region_name = 'ap-southeast-2' # This is Sydney
default_ami_name = 'ami-4959c173' # Ubuntu 12.04.2 x64 EBS Sydney Region
default_ami_name = 'ami-44617116' # CentOS 6.x (HVM) Asia Pacific Region
default_ami_name = 'ami-7b81ca41' # CentOS 6.x (HVM) Sydney Region
default_key_name='appleseed'
default_security_groups=['ssh']
default_instance_type='t1.micro' # too small to build Python stuff, swaps!
# default_instance_type='m1.medium'
default_instance_configuration_script = 'appleseed_ami_instance_configuration_script.sh'

def read_script_as_string(filename):
    import os
    script_directory=os.path.dirname(os.path.abspath(__file__))
    print('script_directory = ' + script_directory)
    if filename :
        content = open(script_directory+'/'+filename).read()
        return content
    return None

def create_instance():
    conn = boto.ec2.connect_to_region(default_region_name)
    conn.run_instances(default_ami_name,
                       key_name=default_key_name,
                       security_groups=default_security_groups,
                       instance_type=default_instance_type
#                       ,user_data=read_script_as_string(default_instance_configuration_script)
                       )

def print_hello():
    print('Hello world')
    
