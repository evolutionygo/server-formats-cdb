--ハーピィ・レディ －鳳凰の陣－ (Anime)
--Harpie Lady Phoenix Formation (Anime)
--fixed by Larry126
function c513000107.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c513000107.cost)
	e1:SetTarget(c513000107.target)
	e1:SetOperation(c513000107.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(c513000107,ACTIVITY_ATTACK,c513000107.counterfilter)
end
c513000107.listed_series={0x64}
c513000107.listed_names={CARD_HARPIE_LADY}
function c513000107.counterfilter(c)
	return not c:IsSetCard(0x64)
end
function c513000107.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(c513000107,tp,ACTIVITY_ATTACK)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_OATH+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTarget(aux.TargetBoolFunction(aux.NOT(c513000107.counterfilter)))
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c513000107.cfilter(c)
	return c:IsFaceup() and c:IsCode(CARD_HARPIE_LADY)
end
function c513000107.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) 
		and Duel.IsExistingMatchingCard(c513000107.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil),1,1-tp,LOCATION_MZONE)
end
function c513000107.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c513000107.cfilter,tp,LOCATION_MZONE,0,nil)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	if ct<=0 or #g<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local sg=g:Select(tp,1,ct,nil)
	Duel.HintSelection(sg)
	if Duel.Destroy(sg,REASON_EFFECT)>0 then
		local atk=Duel.GetOperatedGroup():GetSum(Card.GetPreviousAttackOnField)
		local lp=Duel.GetLP(1-tp)
		Duel.SetLP(1-tp,(lp<=atk) and 0 or (lp-atk))
	end
end