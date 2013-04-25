# coding: utf-8

class MemosController < ApplicationController
  # GET /memos
  # GET /memos.json
  def index
    @memos = Memo.all
    @new_memo = Memo.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @memos }
    end
  end

  # GET /memos/1
  # GET /memos/1.json
  def show
    @memo = Memo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @memo }
    end
  end

  # GET /memos/new
  # GET /memos/new.json
  def new
    @memo = Memo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @memo }
    end
  end

  # GET /memos/1/edit
  def edit
    @memo = Memo.find(params[:id])
  end

  # POST /memos
  # POST /memos.json
  def create
    @memo = Memo.new(params[:memo])

      if @memo.update_attributes(params[:memo])
        status = 'success'
        html = render_to_string partial: 'show', locals: { memo: @memo }
      else
        status = 'error'
      end
    render json: { status: status, data: @memo, html: html }

  end

  # PUT /memos/1
  # PUT /memos/1.json
  def update
    @memo = Memo.find(params[:id])

      if @memo.update_attributes(params[:memo])
        status = 'success'
      else
        status = 'error'
      end
    render json: { status: status, data: @memo }
  end

  # DELETE /memos/1
  # DELETE /memos/1.json
  def destroy
    @memo = Memo.find(params[:id])
    @memo.destroy

    render json: { status: 'success', data: @memo }
  end

  def hello_calculation
      if params[:dest1] == nil || params[:dest2] == nil then
          @input_calcu1 =  "input 初期入力値"
          @input_calcu2 =  "input 初期入力値"
      else
          @input_calcu1 = params[:dest1]
          @input_calcu2 = params[:dest2]
      end

      @input_calcu001 = @input_calcu1
      @aa   = @input_calcu001.gsub(/(\s|　)+/, '')
      @bb   = @aa.scan(/\d+/)
      if @bb.length > 1 then
          @cccc   = @aa.scan(/[^\d]/).shift
          @aaaa = @bb.shift
          @bbbb = @bb.shift
          @input_calcu1 = select_calculation(@aaaa,@bbbb,@cccc)
      end
      @input_calcu002 = @input_calcu2
      @aa   = @input_calcu002.gsub(/(\s|　)+/, '')
      @bb   = @aa.scan(/\d+/)
      if @bb.length > 1 then
          @cccc   = @aa.scan(/[^\d]/).shift
          @aaaa = @bb.shift
          @bbbb = @bb.shift
          @input_calcu2 = select_calculation(@aaaa,@bbbb,@cccc)
      end
      @out_validate = validation_check(@input_calcu1,@input_calcu2)
      @valid_flag = true
      if @out_validate == false then
         begin
            raise StandardError
               rescue => @ex
               @valid_flag = false
           end
      end
      if params[:page] == nil  then
            @selector = {"name" => "1"}
      else
            @selector = params[:page]
      end
      @calc_atom = @selector[:name]
      @output_calcu = select_calculation( @input_calcu1,@input_calcu2, @calc_atom )
      @output_calcu = "入力エラーです。" if  @valid_flag == false
      index
  end
  def select_calculation( input_calcu1,input_calcu2, calc_atom )
      case calc_atom
      when "1","+" then
          @output =  input_calcu1.to_f + input_calcu2.to_f
      when "2","-" then
          @output =  input_calcu1.to_f - input_calcu2.to_f
      when "3","*" then
          @output =  input_calcu1.to_f * input_calcu2.to_f
      when "4","/" then
          @output =  input_calcu1.to_f / input_calcu2.to_f
      end
        return @output
   end
   def validation_check(input_calcu1,input_calcu2)
          size1 = input_calcu1.to_f
          size2 = input_calcu2.to_f
          if size1 > 32767.00 || size2 > 32767.00
              return false
          else
              return true
          end
    end
end
