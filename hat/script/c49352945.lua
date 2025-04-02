--E・HERO ストーム・ネオス
--Elemental HERO Storm Neos
function c49352945.initial_effect(c)
	--Contact Fusion procedure
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,true,true,CARD_NEOS,17955766,54959865)
	Fusion.AddContactProc(c,c49352945.contactfil,c49352945.contactop,c49352945.splimit)
	--Destroy all Spells/Traps on the field
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc49352945(c49352945,1))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c49352945.destg)
	e1:SetOperation(c49352945.desop)
	c:RegisterEffect(e1)
	--Shuffle all cards on the field into the Deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc49352945(c49352945,2))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_DECK)
	e2:SetCondition(c49352945.tdcon)
	e2:SetTarget(c49352945.tdtg)
	e2:SetOperation(c49352945.tdop)
	c:RegisterEffect(e2)
	aux.EnableNeosReturn(c,nil,nil,nil,e2)
end
c49352945.listed_names={CARD_NEOS}
c49352945.material_setcode={0x8,0x3008,0x9,0x1f}
function c49352945.contactfil(tp)
	return Duel.GetMatchingGroup(Card.IsAbleToDeckOrExtraAsCost,tp,LOCATION_ONFIELD,0,nil)
end
function c49352945.contactop(g,tp)
	Duel.ConfirmCards(1-tp,g)
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_COST+REASON_MATERIAL)
end
function c49352945.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
function c49352945.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil,TYPE_SPELL+TYPE_TRAP) end
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,TYPE_SPELL+TYPE_TRAP)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c49352945.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,TYPE_SPELL+TYPE_TRAP)
	Duel.Destroy(g,REASON_EFFECT)
end
function c49352945.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return type(re:GetLabelObject())=='Effect' and re:GetLabelObject()==e
end
function c49352945.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,#g,0,0)
end
function c49352945.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
end