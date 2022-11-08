#script (python)


with open(r'/Users/lidiyadzhumayeva/Desktop/thesis/sample_instances.lp', 'r') as f:
    lines = f.readlines()


with open(r'/Users/lidiyadzhumayeva/Desktop/thesis/prep_sample_instances.lp', 'w') as fp:
    for line in lines:
        fp.write("#external " + line)

    
#end.
