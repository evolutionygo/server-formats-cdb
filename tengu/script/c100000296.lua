--ハーピィの羽根吹雪 (Anime)
--Harpie's Feather Storm (Anime)
function c100000296.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc100000296(c100000296,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c100000296.condition)
	e1:SetTarget(c100000296.target)
	e1:SetOperation(c100000296.activate)
	c:RegisterEffect(e1)
end
c100000296.listed_series={SET_HARPIE}
function c100000296.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsTurnPlayer(tp) and Duel.IsBattlePhase() and tp~=ep and re:IsMonsterEffect()
		and Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsSetCard,SET_HARPIE),tp,LOCATION_MZONE,0,1,nil)
end
function c100000296.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c100000296.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
	Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE|PHASE_BATTLE,1)
end