--幻奏の音姫マイスタリン・シューベルト (Anime)
--Schuberta the Melodious Maestra (Anime)
--scripted by pyrQ
function c511030005.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,true,true,76990617,aux.FilterBoolFunctionEx(Card.IsSetCard,0x9b))
	--Banish and gain ATK
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511030005(c511030005,0))
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c511030005.target)
	e1:SetOperation(c511030005.operation)
	c:RegisterEffect(e1)
end
c511030005.material_setcode=0x9b
function c511030005.filter1(c)
	local fc=c:GetReasonCard()
	local fcc511030005
	local fcmc
	if fc then
		if c:GetFlagEffect(c511030005)==0 then
			fcc511030005=fc:GetFieldID()
			fcmc=fc:GetMaterialCount()
			c:RegisterFlagEffect(c511030005,RESET_EVENT+RESET_TOHAND+RESET_TODECK+RESET_REMOVE+RESET_TOFIELD,0,0,fcc511030005)
			c:RegisterFlagEffect(c511030005+1,RESET_EVENT+RESET_TOHAND+RESET_TODECK+RESET_REMOVE+RESET_TOFIELD,0,0,fcmc)
		end
		local i=Duel.GetMatchingGroupCount(c511030005.filter2,0,LOCATION_GRAVE,LOCATION_GRAVE,c,c:GetFlagEffectLabel(c511030005))
		if i~=(c:GetFlagEffectLabel(c511030005+1)-1) then
			return false
		end
	else
		return false
	end
	return c:IsLocation(LOCATION_GRAVE) and c:IsAbleToRemove()
		and c:GetReason()&0x40008==0x40008
end
function c511030005.filter2(c,fcc511030005)
	return c:IsLocation(LOCATION_GRAVE) and c:IsAbleToRemove()
		and c:GetReason()&0x40008==0x40008
		and c:GetFlagEffectLabel(c511030005)==fcc511030005
end
function c511030005.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:GetReason()&0x40008==0x40008 and c511030005.filter1(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511030005.filter1,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tg=Duel.SelectMatchingCard(tp,c511030005.filter1,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
	local fc=tg:GetFirst():GetFlagEffectLabel(c511030005)
	local i=Duel.GetMatchingGroupCount(c511030005.filter2,tp,LOCATION_GRAVE,LOCATION_GRAVE,tg,fc)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tg1=Duel.SelectMatchingCard(tp,c511030005.filter2,tp,LOCATION_GRAVE,LOCATION_GRAVE,i,i,tg,fc)
	tg:Merge(tg1)
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,tg,#tg,0,0)
end
function c511030005.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetTargetCards(e)
	local ct=Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	local c=e:GetHandler()
	if ct>0 and c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(ct*200)
		c:RegisterEffect(e1)
	end
end