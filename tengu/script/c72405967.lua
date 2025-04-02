--王家の生け贄
--Royal Tribute
function c72405967.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(function(e,tp) return Duel.IsEnvironment(CARD_NECROVALLEY,tp) end)
	e1:SetTarget(c72405967.handestg)
	e1:SetOperation(c72405967.handesop)
	c:RegisterEffect(e1)
end
c72405967.listed_names={CARD_NECROVALLEY}
function c72405967.handestg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_HAND,LOCATION_HAND,1,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,PLAYER_ALL,0)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,PLAYER_ALL,LOCATION_HAND)
end
function c72405967.handesop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsMonster,tp,LOCATION_HAND,LOCATION_HAND,nil)
	if #g>0 then
		Duel.SendtoGrave(g,REASON_EFFECT|REASON_DISCARD)
	end
end