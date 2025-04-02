--ＲＲ－ファイナル・フォートレス・ファルコン (Anime)
--Rac511009567raptor - Final Fortress Falcon (Anime)
function c511009567.initial_effect(c)
	c:EnableReviveLimit()
	--Xyz Summon procedure: 3 Level 12 Winged Beast monsters
	aux.AddXyzProcedure(c,aux.FilterBoolFunctionEx(Card.IsRace,RACE_WINGEDBEAST),12,3)
	--Return all your banished "Rac511009567raptor" monsters to the GY
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511009567(c511009567,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(Cost.Detach(1))
	e1:SetTarget(c511009567.rtgtg)
	e1:SetOperation(c511009567.rtgop)
	c:RegisterEffect(e1,false,REGISTER_FLAG_DETACH_XMAT)
	--Allow 1 "Rac511009567raptor" monster to attack multiple times in a row
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511009567(c511009567,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511009567.atkcon)
	e2:SetCost(c511009567.atkcost)
	e2:SetTarget(c511009567.atktg)
	e2:SetOperation(c511009567.atkop)
	c:RegisterEffect(e2)
end
c511009567.listed_series={SET_RAIDRAPTOR}
function c511009567.rtgfilter(c)
	return c:IsSetCard(SET_RAIDRAPTOR) and c:IsMonster() and c:IsFaceup()
end
function c511009567.rtgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c511009567.rtgfilter,tp,LOCATION_REMOVED,0,nil)
	if chk==0 then return #g>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,#g,tp,0)
end
function c511009567.rtgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511009567.rtgfilter,tp,LOCATION_REMOVED,0,nil)
	if #g>0 then
		Duel.SendtoGrave(g,REASON_EFFECT|REASON_RETURN)
	end
end
function c511009567.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetAttacker()
	return ac and ac:IsRelateToBattle() and ac:IsSetCard(SET_RAIDRAPTOR) and ac:IsControler(tp)
		and ac:CanChainAttack(ac:GetAttackAnnouncedCount()+1,true)
end
function c511009567.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ct=c:GetOverlayCount()
	if chk==0 then return ct>0 and c:CheckRemoveOverlayCard(tp,ct,REASON_COST) end
	local g=c:GetOverlayGroup()
	Duel.SendtoGrave(g,REASON_COST)
end
function c511009567.rmfilter(c)
	return c:IsSetCard(SET_RAIDRAPTOR) and c:IsType(TYPE_XYZ) and c:IsAbleToRemove()
end
function c511009567.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009567.rmfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_GRAVE)
end
function c511009567.atkop(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetAttacker()
	if not (ac:IsRelateToBattle() and ac:IsSetCard(SET_RAIDRAPTOR)) then return end
	local ct=Duel.GetMatchingGroupCount(c511009567.rmfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511009567.rmfilter,tp,LOCATION_GRAVE,0,1,ct,nil)
	if #g>0 and Duel.Remove(g,POS_FACEUP,REASON_EFFECT)>0 then
		local c=e:GetHandler()
		c511009567.chainatkop(c,ac)
		if #g==1 then return end
		--For each "Rac511009567raptor" Xyz Monster you banish from your Graveyard, that "Rac511009567raptor" monster can attack an opponent's monster again in a row
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringc511009567(c511009567,2))
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CLIENT_HINT)
		e1:SetCode(EVENT_DAMAGE_STEP_END)
		e1:SetCountLimit(#g-1)
		e1:SetCondition(c511009567.chainatkcon)
		e1:SetOperation(function() c511009567.chainatkop(c,ac) end)
		e1:SetReset(RESETS_STANDARD_PHASE_END)
		ac:RegisterEffect(e1)
		--Reset the above effect if another monster attacks
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_ATTACK_ANNOUNCE)
		e2:SetCondition(function() return Duel.GetAttacker()~=ac end)
		e2:SetOperation(function() if e1 then e1:Reset() end e2:Reset() end)
		e2:SetReset(RESET_PHASE|PHASE_END)
		Duel.RegisterEffect(e2,tp)
	end
end
function c511009567.chainatkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.GetAttacker()==c and c:CanChainAttack(c:GetAttackAnnouncedCount()+1,true)
end
function c511009567.chainatkop(c,ac)
	Duel.ChainAttack()
	--The consecutive attack must be on a monster
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e1:SetReset(RESET_EVENT|RESETS_STANDARD|RESET_PHASE|PHASE_BATTLE|PHASE_DAMAGE_CAL)
	ac:RegisterEffect(e1)
end