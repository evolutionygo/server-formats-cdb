--コンバート・コンタクト
--Convert Contact
function c82639107.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc82639107(c82639107,0))
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(function(_,tp) return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0 end)
	e1:SetTarget(c82639107.target)
	e1:SetOperation(c82639107.activate)
	c:RegisterEffect(e1)
end
c82639107.listed_series={SET_NEO_SPACIAN}
function c82639107.tgfilter(c)
	return c:IsSetCard(SET_NEO_SPACIAN) and c:IsAbleToGrave()
end
function c82639107.rescon(sg,e,tp,mg)
	return sg:FilterCount(Card.IsLocation,nil,LOCATION_HAND)==1
end
function c82639107.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c82639107.tgfilter,tp,LOCATION_HAND|LOCATION_DECK,0,nil)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=3
		and #g>1 and aux.SelectUnselectGroup(g,e,tp,2,2,c82639107.rescon,0) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,2,tp,LOCATION_HAND|LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c82639107.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c82639107.tgfilter,tp,LOCATION_HAND|LOCATION_DECK,0,nil)
	if #g<2 then return end
	local sg=aux.SelectUnselectGroup(g,e,tp,2,2,c82639107.rescon,1,tp,HINTMSG_TOGRAVE)
	if #sg~=2 then return end
	if Duel.SendtoGrave(sg,REASON_EFFECT)==2 and sg:FilterCount(Card.IsLocation,nil,LOCATION_GRAVE)==2
		and Duel.IsPlayerCanDraw(tp) then
		Duel.ShuffleDeck(tp)
		Duel.BreakEffect()
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end