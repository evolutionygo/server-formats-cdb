--レア・ヴァリュー (Anime)
--Rare Value (Anime)
function c511600378.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511600378.condition)
	e1:SetTarget(c511600378.target)
	e1:SetOperation(c511600378.activate)
	c:RegisterEffect(e1)
end
c511600378.listed_series={0x1034}
function c511600378.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsSetCard,0x1034),tp,LOCATION_SZONE,0,2,nil)
end
function c511600378.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c511600378.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.FaceupFilter(Card.IsSetCard,0x1034),tp,LOCATION_SZONE,0,nil):RandomSelect(tp,1,nil)
	if #sg>0 then
		Duel.SendtoGrave(sg,REASON_EFFECT)
		if sg:GetFirst():IsLocation(LOCATION_GRAVE) then
			Duel.Draw(tp,2,REASON_EFFECT)
		end
	end
end