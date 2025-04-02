--レベルアップ！
--Level Up!
function c25290459.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c25290459.cost)
	e1:SetTarget(c25290459.target)
	e1:SetOperation(c25290459.activate)
	c:RegisterEffect(e1)
end
c25290459.listed_series={0x41}
function c25290459.costfilter(c,e,tp)
	if not c:IsSetCard(0x41) or not c:IsAbleToGraveAsCost() or not c:IsFaceup() then return false end
	return c.listed_names and Duel.IsExistingMatchingCard(c25290459.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,c,e,tp)
end
function c25290459.spfilter(c,class,e,tp)
	return c:IsMonster() and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
		and clasc25290459.listed_names and c:IsCode(table.unpack(clasc25290459.listed_names))
end
function c25290459.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c25290459.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c25290459.costfilter,tp,LOCATION_MZONE,0,1,nil,e,tp) 
			and Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c25290459.costfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SendtoGrave(g,REASON_COST)
	local code=g:GetFirst():GetOriginalCode()
	Duel.SetTargetParam(code)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c25290459.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local code=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local class=Duel.GetMetatable(code)
	if class==nil or clasc25290459.listed_names==nil then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c25290459.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,class,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)
		if tc:GetPreviousLocation()==LOCATION_DECK then Duel.ShuffleDeck(tp) end
	end
end