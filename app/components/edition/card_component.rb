class Edition::CardComponent < ViewComponent::Base
  def initialize(edition, in_evidence: false)
    @edition = edition
    @project = @edition.project  
    @in_evidence = in_evidence
  end
end

