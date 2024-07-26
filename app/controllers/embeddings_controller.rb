class EmbeddingsController < ApplicationController
  before_action :set_embedding, only: %i[ show edit update destroy ]

  # GET /embeddings
  def index
    @embeddings = Embedding.all
  end

  # GET /embeddings/1
  def show
  end

  # GET /embeddings/new
  def new
    @embedding = Embedding.new
  end

  # GET /embeddings/1/edit
  def edit
  end

  # POST /embeddings
  def create
    @embedding = Embedding.new(embedding_params)

    if @embedding.save
      redirect_to @embedding, notice: "Embedding was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /embeddings/1
  def update
    if @embedding.update(embedding_params)
      redirect_to @embedding, notice: "Embedding was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /embeddings/1
  def destroy
    @embedding.destroy!
    redirect_to embeddings_url, notice: "Embedding was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_embedding
      @embedding = Embedding.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def embedding_params
      params.require(:embedding).permit(:document_id, :context, :embedding)
    end
end
