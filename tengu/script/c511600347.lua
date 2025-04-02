--Ａｉ－コンタクト (Anime)
--A.I. Contact (Anime)
--Scripted by Larry126
local s,c511600347,alias=GetID()
function c511600347.initial_effect(c)
	alias=c:GetOriginalCodeRule()
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,alias,EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c511600347.target)
	e1:SetOperation(c511600347.activate)
	c:RegisterEffect(e1)
end
function c511600347.rdfilter(c,code)
	return c:IsCode(code) and c:IsAbleToDeck()
end
function c511600347.filter(c,p)
	return c:IsFaceup() and Duel.IsExistingMatchingCard(c511600347.rdfilter,p,LOCATION_HAND,0,1,nil,c:GetCode())
end
function c511600347.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_FZONE) and c511600347.filter(chkc,tp) end
	if chk==0 then return Duel.IsPlayerCanDraw(tp,3)
		and Duel.IsExistingTarget(c511600347.filter,tp,LOCATION_FZONE,LOCATION_FZONE,1,nil,tp) end
	Duel.SelectTarget(tp,c511600347.filter,tp,LOCATION_FZONE,LOCATION_FZONE,1,1,nil,tp)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(3)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,3)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND)
end
function c511600347.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local rg=Duel.SelectMatchingCard(tp,c511600347.rdfilter,tp,LOCATION_HAND,0,1,1,nil,tc:GetCode())
		if #rg>0 then
			Duel.ConfirmCards(1-tp,rg)
			Duel.SendtoDeck(rg,nil,2,REASON_EFFECT)
			Duel.ShuffleDeck(tp)
			Duel.BreakEffect()
			local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
			Duel.Draw(p,d,REASON_EFFECT)
		end
	end
end