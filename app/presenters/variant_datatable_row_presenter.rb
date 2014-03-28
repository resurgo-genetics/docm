class VariantDatatableRowPresenter < SimpleDelegator
  delegate :link_to, to: :@view_context

  def initialize(variant, view_context)
    @variant = variant
    @view_context = view_context
    super(variant)
  end

  def as_json
    [
      location.chromosome,
      location.start,
      location.stop,
      location.reference_read,
      variant,
      gene.name,
      amino_acid.name,
      mutation_type.name,
      disease_list,
      source_list
    ]
  end

  private
  def disease_list
    diseases.map(&:name).join(', ')
  end

  def source_list
    sources.map do |s|
      link_to(s.pmid_id, "http://www.ncbi.nlm.nih.gov/pubmed/#{s.pmid_id}")
    end.join(', ')
  end

end