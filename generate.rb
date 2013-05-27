require 'fileutils'
require 'configure.rb'

#The graph element is a container for all elements that determine the structure of the graph. This element must contain one actors element, one degree element and one rate element. It may also contain one initialTokens element and/or one structure element. 
#The graphProperties element is a container for all generation settings related to the properties of the components in an SDF graph. This element must contain one procs element and one execTime element. It may also contain one or more of the following elements: stateSize, tokenSize, bufferSize, bandwidthRequirement, latencyRequirement, and/or throughputConstraint. 
def generate_sdf3(graph,graphProperties)
#change directory
Dir.chdir("/home/blue/sdf3/build/release/Linux/bin")#Note:Please change this path accroding to your own file location.Respectively,the path 'sdf3/build/release/Linux/bin' is the default path which holds the executed commands and the output files.


path = '/home/blue/sdf3/sdf/testbench/option.opt'#path is the original option file location,used to cover the temp.opt
dst = '/home/blue/sdf3/sdf/testbench/temp.opt'#dst is the path of option file which used to rewrite by user.Note:change these two paths accroding to your own file location. 

FileUtils.cp path,dst#initialize temp file,making its every attribute to unknown as 'X'

file = File.open(dst,"r")
  content = file.read
  file.close

  #replace the 'X' with the data previously set in graph and graphProperties
  content.gsub!(/actors nr="X"/,'actors nr="'+graph.actors.nr+'"')
  content.gsub!(/degree avg="X" var="X" min="X" max="X"/,'degree avg="'+graph.degree.avg+'" var="'+graph.degree.var+'" min="'+graph.degree.min+'" max="'+graph.degree.max+'"')
  content.gsub!(/rate avg="X" var="X" min="X" max="X" repetitionVectorSum="X"/,'rate avg="'+graph.rate.avg+'" var="'+graph.rate.var+'" min="'+graph.rate.min+'" max="'+graph.rate.max+'" repetitionVectorSum="'+graph.rate.repetitionVectorSum+'"')
  content.gsub!(/initialTokens prop="X"/,'initialTokens prop="'+graph.initial.tokens+'"')
  content.gsub!(/structure stronglyConnected="X" acyclic="X"/,'structure stronglyConnected="'+graph.structure.stronglyConnected+'" acyclic="'+graph.structure.acyclic+'"')

  content.gsub!(/procs nrTypes="X" mapChance="X"/,'procs nrTypes="'+graphProperties.proc.nrTypes+'" mapChance="'+graphProperties.proc.mapChance+'"')
  content.gsub!(/execTime avg="X" var="X" min="X" max="X"/,'execTime avg="'+graphProperties.execTime.avg+'" var="'+graphProperties.execTime.var+'" min="'+graphProperties.execTime.min+'" max="'+graphProperties.execTime.max+'"')
  content.gsub!(/stateSize avg="X" var="X" min="X" max="X"/,'stateSize avg="'+graphProperties.stateSize.avg+'" var="'+graphProperties.stateSize.var+'" min="'+graphProperties.stateSize.min+'" max="'+graphProperties.stateSize.max+'"')
  content.gsub!(/tokenSize avg="X" var="X" min="X" max="X"/,'tokenSize avg="'+graphProperties.tokenSize.avg+'" var="'+graphProperties.tokenSize.var+'" min="'+graphProperties.tokenSize.min+'" max="'+graphProperties.tokenSize.max+'"')
  content.gsub!(/bandwidthRequirement avg="X" var="X" min="X" max="X"/,'bandwidthRequirement avg="'+graphProperties.bandwidthRequirement.avg+'" var="'+graphProperties.bandwidthRequirement.var+'" min="'+graphProperties.bandwidthRequirement.min+'" max="'+graphProperties.bandwidthRequirement.max+'"')
  content.gsub!(/latencyRequirement   avg="X" var="X" min="X" max="X"/,'latencyRequirement   avg="'+graphProperties.latencyRequirement.avg+'" var="'+graphProperties.latencyRequirement.var+'" min="'+graphProperties.latencyRequirement.min+'" max="'+graphProperties.latencyRequirement.max+'"')
  content.gsub!(/autoConcurrencyDegree="X" scaleFactor="X"/,'autoConcurrencyDegree="'+graphProperties.throughputConstraint.autoConcurrencyDegree+'" scaleFactor="'+graphProperties.throughputConstraint.scaleFactor+'"')

File.open(dst,"w"){|f| f << content}#write the replacement to temp file


`./sdf3generate-sdf --settings /home/blue/sdf3/sdf/testbench/temp.opt --output -temp`#command line to generate XML file
`./sdf3print-sdf --graph /home/blue/sdf3/build/release/Linux/bin/-temp --format dot --output -tempfile`#command line to generate graph.Note:Please change these two paths accroding to your own file location. 
end



