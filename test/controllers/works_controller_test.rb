require "test_helper"

describe WorksController do
  it "should get index" do
    get works_url
    value(response).must_be :successful?
  end

  describe "show" do
    it "should get show" do
      valid_work_id = works(:one).id

      get works_url(valid_work_id)
      value(response).must_be :successful?
    end

    it "should give a flash notice instead if invalid work" do
      invalid_id = works(:one).id
      works(:one).destroy

      get work_path(invalid_id)

      must_respond_with :redirect
      expect(flash[:error]).must_equal "Unknown work"
    end
  end 

  describe "new" do
    it "should get new" do
      get new_work_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "should create new work" do
      work_hash = {
        work: {
          category: "album",
          title: "Working!"
        }
      }

      expect {
        post works_path, params: work_hash
      }.must_change "Work.count", 1

      must_respond_with :redirect
    end

    it "should respond with bad request if title missing" do
      work_hash = {
        work: {
          category: "album",
          title: ""
        }
      }

      expect {
        post works_path, params: work_hash
      }.wont_change "Work.count"

      must_respond_with :bad_request
    end
  end

  describe "edit" do
    it "should get edit" do
      get edit_work_path(works(:one).id)

      must_respond_with :success
    end
  end

  describe "update" do
    it "should update work" do
      work_hash = {
        work: {
          category: "movie",
          title: "Me, Working!"
        }
      }

      patch work_path(works(:one).id), params: work_hash

      must_respond_with :redirect
      expect(Work.find_by(title: "Me, Working!")).wont_be_nil
    end

    it "will respond with a bad requet if the title is empty" do
    
    end
  end

end
