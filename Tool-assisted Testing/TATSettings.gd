extends Node

enum Mode {NORMAL, TEST}

export(Array, NodePath) var Characters = []
export(Array, String) var TatFiles = []
export(Mode) var mode = NORMAL