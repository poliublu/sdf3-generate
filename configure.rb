require 'generate.rb'

def config
#using struct to store attributes of each factor
actors = Struct.new("Actors",:nr)#the nr indicates maximum number of actors in the graph
degree = Struct.new("Degree",:avg,:var,:min,:max)#The number of incoming and outgoing channels on an actor 
rate = Struct.new("Rate",:avg,:var,:min,:max,:repetitionVectorSum)#The rate of a port is drawn from a normalized distribution and within the bounds specified in the rate element. Note that some port may be assigned a rate outside the specified bounds in order to make the graph consistent.
initialtokens = Struct.new("Initial",:prop)#The prop attribute specifies the probability that initial tokens are added to a channel.
structure = Struct.new("Structure",:stronglyConnected,:acyclic)#The attributes stronglyConnected and acyclic on the element structure can be used to control the structure of the graph. Note that when setting the stronglyConnected to true, it is not guaranteed that the generated graph contains as many nodes as specified in the actors element.

#actors,degree,rate,initial,structure constitue the 'graph'
graph = Struct.new("Graph",:actors,:degree,:rate,:initial,:structure)

proc = Struct.new("Proc",:nrTypes,:mapChance)#The nrTypes specifies the number of different processor types that can be used when generating execution time for the actors. The mapChance attribute determines the chance that an actor can be mapped to a processor and will therefore be assigned an execution time.
execTime = Struct.new("ExecTime",:avg,:var,:min,:max)#The execution time of an actor is drawn from a normalized distribution and within the bounds specified in the execTime element. 
stateSize = Struct.new("StateSize",:avg,:var,:min,:max)#When the stateSize element is present, a stateSize element is generated for every actor in the SDF graph.The size of the state is drawn from a normalized distribution and within the specified bounds.
tokenSize = Struct.new("TokenSize",:avg,:var,:min,:max)#When the tokenSize element is present, a tokenSize element is generated for every channel in the SDF graph. The size of the token is drawn from a normalized distribution and within the specified bounds. 
bandwidthRequirement = Struct.new("BandwidthRequirement",:avg,:var,:min,:max)#When the bandwidthRequirement element is present, a bandwidth element is generated for every channel in the SDF graph. The bandwidth is drawn from a normalized distribution and within the specified bounds.
latencyRequirement = Struct.new("LatencyRequirement",:avg,:var,:min,:max)#When the latencyRequirement element is present, a latency element is generated for every channel in the SDF graph. The value of the latency is drawn from a normalized distribution and within the specified bounds.
throughputConstraint = Struct.new("ThroughputConstrain",:autoConcurrencyDegree,:scaleFactor)#When the throughputConstraint element is present, a throughput constraint is added to the graph. This throughput constraint is a random value between zero and the maximal achievable throughput of the graph. The scaleFactor attribute can be used to scale the throughput constraint. When the autoConcurrencyDegree attribute is present, its value is used to constrain the auto-concurrency of the actors in the graph prior to computing the maximal throughput of the graph.

#proc,execTime,stateSize,tokenSize,bandwidthRequirement,latencyRequirement,throughputConstraint constitue 'graphProperties'
graphProperties = Struct.new("GraphProperties",:proc,:execTime,:stateSize,:tokenSize,:bandwidthRequirement,:latencyRequirement,:throughputConstraint)

ars = actors.new("5")
deg = degree.new("2","1","1","3")
rte = rate.new("1","1","1","1","10")
ini = initialtokens.new("0")
struct = structure.new("true","false")
gph = graph.new(ars,deg,rte,ini,struct)

pro = proc.new("3","0.25")
exet = execTime.new("10","0","10","10")
stsize = stateSize.new("1","1","1","1")
tksize = tokenSize.new("1","1","1","1")
bdRequirement = bandwidthRequirement.new("2","0","1","4")
ltRequirement = latencyRequirement.new("2","0","1","4")
tpConstraint = throughputConstraint.new("1","0.1")
gphPro = graphProperties.new(pro,exet,stsize,tksize,bdRequirement,ltRequirement,tpConstraint)
#invoke function generate_sdf3 in 'generate.rb'
generate_sdf3(gph,gphPro)


end
