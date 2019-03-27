package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.geotools.geometry.Envelope2D;

import nl.rivm.nca.api.domain.AssessmentRequest;
import nl.rivm.nca.api.domain.AssessmentResultResponse;

public interface ControllerInterface {

	public List<AssessmentResultResponse> run(String correlationId, AssessmentRequest assessmentRequest) throws IOException, ConfigurationException, InterruptedException;
	
	public Envelope2D calculateExtend(File geoTiffFile) throws IOException;
	
}
