class Admin::ContractorsController < Admin::BaseController
  def index
    @contractors = Contractor.all
  end
end
