import gdb

vm_hwm_history = []
vm_rss_history = []

unit_map = dict((u, 2**(i*10)) for i,u in enumerate(["", "k", "M", "G", "T"]))

def read_mem_value(s):
    if s[-1] != "B":
        return 0
    
    unit = s[-2] if s[-2] in unit_map else "" 
    value = int(s[:-2].strip())

    return value * unit_map[unit]  

class MemoryInfo(gdb.Command):
    def __init__(self):
        super(MemoryInfo, self).__init__("meminfo", gdb.COMMAND_USER)

    def invoke(self, args, from_tty):
        pid = str(gdb.selected_inferior().pid)

        with open("/proc/{}/status".format(pid)) as f:
            status = dict((part.strip() for part in line.split(":", 2)) for line in f.readlines())

        vm_hwm = read_mem_value(status["VmHWM"])
        vm_rss = read_mem_value(status["VmRSS"])

        global vm_hwm_history
        global vm_rss_history

        vm_hwm_history.append(vm_hwm)
        vm_rss_history.append(vm_rss)

        name = gdb.selected_frame().name()
        print("{}: Cur: {}, Peak: {}".format(name, vm_rss, vm_hwm), file=outfile)

MemoryInfo()
