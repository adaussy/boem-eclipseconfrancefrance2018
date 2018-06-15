package org.eclipsecon.france.demo

import org.junit.Before
import org.eclipse.emf.ecore.resource.ResourceSet
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl
import org.eclipse.uml2.uml.UMLPackage
import org.eclipse.uml2.uml.internal.resource.UMLResourceFactoryImpl
import org.eclipse.emf.common.util.URI

@SuppressWarnings("restriction")
class AbstractUMLTest {

	protected var ResourceSet rs;
	protected val uri = URI.createFileURI("result\\test.uml")
	

	@Before
	@SuppressWarnings("restriction")
	def void setup() {
		rs = new ResourceSetImpl
		rs.packageRegistry.put(UMLPackage.eNS_URI, UMLPackage.eINSTANCE)
		rs.resourceFactoryRegistry.extensionToFactoryMap.put("uml", new UMLResourceFactoryImpl)
	}

	protected def getResourceSet() {
		return rs;
	}

}
