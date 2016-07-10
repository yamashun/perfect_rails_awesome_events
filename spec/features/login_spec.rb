# -*- coding: utf-8 -*-
require 'spec_helper'


describe 'ユーザーがイベントの参加や登録を行うために、ログインをする', type: :feature do
  context 'トップページに遷移し、"Twitterでログインをクリックしたとき"' do
    context 'かつTwitterでログインに成功したとき' do
      before do
        visit root_path
        click_link 'Twitterでログイン'
      end

      it 'トップページに遷移していること' do
        expect(page.current_path).to eq root_path
      end

      it '"ログインしました"と表示されること' do
        expect(page).to have_content 'ログインしました'
      end
    end
  end
end