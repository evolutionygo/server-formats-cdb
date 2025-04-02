--コンバート・コンタクト (Anime)
--Convert Contact (Anime)
--Scripted by Larry126
function c511600348.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DRAW+CATEGORY_DECKDES+CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511600348.condition)
	e1:SetTarget(c511600348.target)
	e1:SetOperation(c511600348.activate)
	c:RegisterEffect(e1)
end
c511600348.listed_series={0x1f}
function c511600348.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)==0
end
function c511600348.filter(c)
	return c:IsSetCard(0x1f) and c:IsAbleToGrave()
end
function c511600348.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
	if chk==0 then return ct>0 and Duel.IsPlayerCanDraw(tp,ct+1)
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=ct+2
		and Duel.IsExistingMatchingCard(c511600348.filter,tp,LOCATION_HAND,0,1,nil)
		and Duel.IsExistingMatchingCard(c511600348.filter,tp,LOCATION_DECK,0,1,nil)
	end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct+1)
end
function c511600348.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c511600348.filter,tp,LOCATION_HAND,0,nil)
	local g2=Duel.GetMatchingGroup(c511600348.filter,tp,LOCATION_DECK,0,nil)
	if #g1>0 and #g2>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg2=g2:Select(tp,1,1,nil)
		if Duel.SendtoGrave(sg1+sg2,REASON_EFFECT)==2 then
			local g=Duel.GetOperatedGroup()
			if g:FilterCount(Card.IsLocation,nil,LOCATION_GRAVE)<2 then return end
			Duel.ShuffleDeck(tp)
			local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
			Duel.Draw(p,1,REASON_EFFECT)
			local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
			if ct>0 then
				Duel.BreakEffect()
				Duel.Draw(p,ct,REASON_EFFECT)
			end
		end
	end
end