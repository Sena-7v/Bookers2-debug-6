class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    if @book_comment.save
      render :book_comment
    else
      @user = @book.user
      @Book = Book.new
      render :error
    end
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    @book = Book.find(params[:book_id])
    render :book_comment
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
