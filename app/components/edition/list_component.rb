class Edition::ListComponent < ViewComponent::Base
  def initialize(editions, current_user, in_evidence: false)
    @editions = editions
    @current_user = current_user
    @in_evidence = in_evidence
  end
end


