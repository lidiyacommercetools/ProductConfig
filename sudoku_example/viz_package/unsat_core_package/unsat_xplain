#script (python)

lit2sym = {}
current_core = []

def on_core(corelits):
    global current_core
    print("Unsat core:")
    for l in corelits:
        print(lit2sym[l])
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
        print("Instance is satisfiable")
        return

    is_sym_used = {sym: False for sym in current_core}
    core_minimized = False
    while not core_minimized:
        current_sym = next(sym for sym in current_core if not is_sym_used[sym])
        current_core.remove(current_sym)
        is_sym_used[current_sym] = True

        res = ctl.solve(assumptions=[(sym,True) for sym in current_core], on_core=on_core)
        if res.unsatisfiable:
            print(current_sym,"is not in the minimal core")
        else:
            print(current_sym,"appears in the minimal core")
            current_core.append(current_sym)

        core_minimized = all((is_sym_used[sym] for sym in current_core))

    print("Minimal core:")
    for sym in current_core:
        print(sym)
        
#end.
