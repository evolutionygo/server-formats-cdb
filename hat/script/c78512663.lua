--E・HERO マグマ・ネオス
--Elemental HERO Magma Neos
function c78512663.initial_effect(c)
	--Contact Fusion procedure
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,true,true,CARD_NEOS,89621922,80344569)
	Fusion.AddContactProc(c,c78512663.contactfil,c78512663.contactop,c78512663.splimit)
	--Increase ATK
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c78512663.atkval)
	c:RegisterEffect(e1)
	--Return all cards on the field to the hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc78512663(c78512663,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_DECK)
	e2:SetCondition(c78512663.thcon)
	e2:SetTarget(c78512663.thtg)
	e2:SetOperation(c78512663.thop)
	c:RegisterEffect(e2)
	aux.EnableNeosReturn(c,nil,nil,nil,e2)
end
c78512663.listed_names={CARD_NEOS}
c78512663.material_setcode={0x8,0x3008,0x9,0x1f}
function c78512663.contactfil(tp)
	return Duel.GetMatchingGroup(Card.IsAbleToDeckOrExtraAsCost,tp,LOCATION_ONFIELD,0,nil)
end
function c78512663.contactop(g,tp)
	Duel.ConfirmCards(1-tp,g)
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_COST+REASON_MATERIAL)
end
function c78512663.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
function c78512663.atkval(e,c)
	return Duel.GetFieldGroupCount(0,LOCATION_ONFIELD,LOCATION_ONFIELD)*400
end
function c78512663.thcon(e,tp,eg,ep,ev,re,r,rp)
	return type(re:GetLabelObject())=='Effect' and re:GetLabelObject()==e
end
function c78512663.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,#g,0,0)
end
function c78512663.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
end