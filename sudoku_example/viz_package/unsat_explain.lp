#script (python)

lit2sym = {}
current_core = []

def on_core(corelits):
    global current_core
    current_core = [lit2sym[lit] for lit in corelits]

def main(ctl):
    ctl.ground([("base",[])])
    
    for a in ctl.symbolic_atoms:
        lit2sym[a.literal] = a.symbol

    assumptions = [(a.symbol.arguments[0],True) for a in ctl.symbolic_atoms.by_signature("assume", 1)]
    assumptions.sort(key=str)
    res = ctl.solve(assumptions=assumptions,
              on_core=on_core)
    if not res.unsatisfiable:
        return

    is_sym_used = {sym: False for sym in current_core}
    core_minimized = False
    while not core_minimized:
        current_sym = next(sym for sym in current_core if not is_sym_used[sym])
        current_core.remove(current_sym)
        is_sym_used[current_sym] = True

        res = ctl.solve(assumptions=[(sym,True) for sym in current_core], on_core=on_core)

        if not res.unsatisfiable:
            current_core.append(current_sym)
        #else:
            #current_core.append(current_sym)

        core_minimized = all((is_sym_used[sym] for sym in current_core))

    new_current_core = []
    for sym in current_core:
        print(str(sym) + ".")

    with open(r'/Users/lidiyadzhumayeva/Desktop/thesis/unsat_core.lp', 'w') as fp:
        for item in current_core:
         # write each item on a new line
            fp.write("initial_unsat(" + "%s\n" % item + "). ")
        
#end.

