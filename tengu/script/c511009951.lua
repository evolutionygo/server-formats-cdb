--ウィンドペガサス＠イグニスター (Anime)
--Wind Pegasus @Ignister (Anime)
local s,c511009951,alias=GetID()
function c511009951.initial_effect(c)
	alias=c:GetOriginalCodeRule()
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunctionEx(Card.IsAttribute,ATTRIBUTE_WIND),1,1,aux.NonTuner(nil),1,99)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511009951(alias,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,alias)
	e1:SetTarget(c511009951.target)
	e1:SetOperation(c511009951.operation)
	c:RegisterEffect(e1,false,REGISTER_FLAG_DETACH_XMAT)
	--to deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511009951(alias,1))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,{alias,1})
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCondition(c511009951.tdcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c511009951.tdtg)
	e2:SetOperation(c511009951.tdop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCondition(aux.NOT(c511009951.tdcon))
	e3:SetOperation(c511009951.checkop)
	c:RegisterEffect(e3)
end
c511009951.listed_series={0x135}
function c511009951.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x135)
end
function c511009951.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c511009951.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsControler(1-tp) and c511009951.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c511009951.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(c511009951.desfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511009951.desfilter,tp,0,LOCATION_ONFIELD,1,Duel.GetMatchingGroupCount(c511009951.filter,tp,LOCATION_MZONE,0,nil),nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c511009951.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetTargetCards(e)
	Duel.Destroy(g,REASON_EFFECT)
end
function c511009951.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(c511009951)>0
end
function c511009951.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsAbleToDeck() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToDeck,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,#g,0,0)
end
function c511009951.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)
	end
end
function c511009951.cfilter(c,p)
	return c:GetPreviousTypeOnField()&(TYPE_SPELL|TYPE_TRAP)>0 and c:GetReasonPlayer()~=p
end
function c511009951.checkop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c511009951.cfilter,1,nil,tp) then
		e:GetHandler():RegisterFlagEffect(c511009951,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
	end
end