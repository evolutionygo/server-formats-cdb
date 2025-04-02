--イビリチュア・プシュケローネ
--Gishki Psychelone
function c30334522.initial_effect(c)
	c:EnableReviveLimit()
	--Look at 1 random card and shuffle it into the Deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc30334522(c30334522,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c30334522.target)
	e1:SetOperation(c30334522.operation)
	c:RegisterEffect(e1)
end
c30334522.listed_series={0x3a}
function c30334522.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)~=0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RACE)
	local rc=Duel.AnnounceRace(tp,1,RACE_ALL)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTRIBUTE)
	local at=Duel.AnnounceAttribute(tp,1,ATTRIBUTE_ALL)
	e:SetLabel(rc,at)
end
function c30334522.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local tc=Duel.GetFieldGroup(tp,0,LOCATION_HAND):RandomSelect(tp,1):GetFirst()
	Duel.ConfirmCards(tp,tc)
	local rc,at=e:GetLabel()
	if tc:IsRace(rc) and tc:IsAttribute(at) then
		Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)
	else Duel.ShuffleHand(1-tp) end
end