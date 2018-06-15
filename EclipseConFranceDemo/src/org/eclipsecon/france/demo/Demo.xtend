package org.eclipsecon.france.demo

import org.junit.Test
import org.eclipse.uml2.uml.Model
import fr.ibp.odv.boem.lib.BoemFactory
import org.eclipse.uml2.uml.UMLPackage
import org.eclipse.uml2.uml.Interface

import static org.junit.Assert.*
import static extension fr.ibp.odv.boem.lib.Boems.*
import java.util.Collections
import org.eclipse.uml2.uml.NamedElement
import org.eclipse.uml2.uml.Generalization
import org.eclipse.uml2.uml.Operation
import org.eclipse.uml2.uml.Parameter
import org.eclipse.uml2.uml.ParameterDirectionKind

class Demo extends AbstractUMLTest{
	
	extension BoemFactory factory = new BoemFactory(UMLPackage.eINSTANCE).registerIdProvider([
		if (it instanceof NamedElement) {
			return it.name
		}
		return null
	])
	
	@Test
	def void test() {
		val modelAccessor = Model.build[
			name = "myUmlModel"
			packagedElements += #[
				Interface.build[
					name = "it1"
				],
				Interface.build[
					name = "it2"
					generalizations += Generalization.build[
						specific = Interface << "it2"
						general = Interface << "it3"
					]
				],
				Interface.build[
					name = "it3"
					ownedOperations += Operation.build [
						name = "op1"
						ownedParameters += Parameter.build [
							name = "par1"
							direction = ParameterDirectionKind.RETURN_LITERAL
							type = Interface << "it1"
						]
					]
				]
			]
			
		].buildTree(resourceSet, uri)
		
		//Check if inheritance is well defined among it2 and it3
		val it2 = modelAccessor.access(Interface, "it2")
		assertEquals(1, it2.allOperations.size) 
		
		//save the model to result/test.uml
		resourceSet.getResource(uri, false).save(Collections.emptyMap)
	}
}
