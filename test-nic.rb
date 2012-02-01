require './lib/MachineNics'
require 'pp'
n0 = MachineNics.create_from_hash({ fw0: {bridge0: {tap104: nil, tap105: nil}, tap200: nil}}).display_df
n0 = MachineNics.create_from_hash({ fw0: {bridge0: {tap104: nil, tap105: nil}, tap200: nil}}).display
n0.create
n0.destroy
n1 = MachineNics.create_from_hash({ fw1: {bridge0: [:tap104, :tap105], tap200: nil}}).display
n1.create
n1.destroy

n1 = MachineNics.create_from_hash({ fw2: {tap201: nil, tap202: nil, bridge0: {lagg2: {tap104: nil, tap105: nil}, lagg3: {tap106: nil, tap107: nil}}}}).display
n2 = MachineNics.create_from_hash({ fw3: [:tap201, :tap202, bridge0: {lagg2: {tap104: nil, tap105: nil}, lagg3: {tap106: nil, tap107: nil}}]}).display
n3 = MachineNics.create_from_hash({ fw4: [:tap201, :tap202, bridge0: {lagg2: [:tap104, :tap105], lagg3: {tap106: nil, tap107: nil}}]}).display
n4 = MachineNics.create_from_hash({ fw5: [:tap201, :tap202, bridge0: {lagg2: [:tap104, :tap105], lagg3: [:tap106, :tap107]}]}).display
n4.create
n4.destroy

n5 = MachineNics.create_from_hash({ fw6: [:tap201, :tap202, bridge0: [{lagg2: [:tap104, :tap105, {bridge1: [:tap201, :tap202]}], lagg3: [:tap106, :tap107]}, :tap200]]}).display
n5 = MachineNics.create_from_hash({ fw6: [:tap201, :tap202, bridge0: [{lagg2: [:tap104, :tap105, {bridge1: [:tap201, :tap202]}], lagg3: [:tap106, :tap107]}, :tap200]]}).display_df
puts "length fw6: #{n5.length(:fw6)}, tap201 #{n5.length(:tap201)}, bridge0: #{n5.length(:bridge0)}, lagg2: #{n5.length(:lagg2)}, lagg3: #{n5.length(:lagg3)}"
puts "sorted #{n5.children[:fw6].sort {|a,b| a.length <=> b.length }.reverse}"
pp n5
n5.create
n5.destroy

##
n6 = MachineNics.create_from_hash({ fw7: [:tap201, :tap202_1496]}).display
puts n6.parent_of[:tap201]
p n6
n7 = MachineNics.create_from_hash({ fw7: {bridge0: [:tap201, :tap202, {lagg0: [:tap101, :tap102]}], vlan101: :tap1}}).display
n7.create
n8 = MachineNics.create_from_hash({ fw7: {bridge0: [:tap201_1496, :tap202_1496, {lagg0: [:tap101_1496, :tap102_1496], vlan10100: :tap2}], vlan101: :tap1, lagg1: [:tap150_1496, :tap151_1496], bridge1: { lagg2: [:tap170, :tap171], tap180: nil}}}).display
n8.create
puts `ifconfig`
pp n8

n8.destroy
