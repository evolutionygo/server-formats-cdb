--ナチュル・ホーストニードル
--Naturia Horneedle
function c84905691.initial_effect(c)
	--Destroy Special Summoned monster(s)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc84905691(c84905691,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(aux.CostWithReplace(c84905691.descost,CARD_NATURIA_CAMELLIA))
	e1:SetTarget(c84905691.destg)
	e1:SetOperation(c84905691.desop)
	c:RegisterEffect(e1)
end
c84905691.listed_series={0x2a}
function c84905691.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,aux.FaceupFilter(Card.IsSetCard,0x2a),1,false,nil,c) end
	local g=Duel.SelectReleaseGroupCost(tp,aux.FaceupFilter(Card.IsSetCard,0x2a),1,1,false,nil,c)
	Duel.Release(g,REASON_COST)
end
function c84905691.desfilter(c,e,tp)
	return c:IsSummonPlayer(1-tp) and (not e or c:IsRelateToEffect(e))
end
function c84905691.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g=eg:Filter(c84905691.desfilter,nil,nil,tp)
	if chk==0 then return #g>0 and not c:IsStatus(STATUS_CHAINING) and not eg:IsContains(c) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c84905691.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c84905691.desfilter,nil,e,tp)
	if #g>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end