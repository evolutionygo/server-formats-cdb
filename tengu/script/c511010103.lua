--Ｎｏ．１０３ 神葬零嬢ラグナ・ゼロ (Anime)
--Number 103: Ragnazero (Anime)
Duel.EnableUnofficialProc(PROC_STATS_CHANGED)
Duel.LoadCardScript("c94380860.lua")
function c511010103.initial_effect(c)
	--Xyz Summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--Cannot be destroyed by battle, except with a "Number" monster
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(aux.NOT(aux.TargetBoolFunction(Card.IsSetCard,SET_NUMBER)))
	c:RegisterEffect(e1)
	--Destroy 1 monster your opponent controls
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511010103(c511010103,0))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(511001265)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(aux.dxmcostgen(1,1,nil))
	e2:SetTarget(c511010103.destg)
	e2:SetOperation(c511010103.desop)
	c:RegisterEffect(e2,false,REGISTER_FLAG_DETACH_XMAT)
end
c511010103.listed_series={SET_NUMBER}
c511010103.aux.xyz_number=103
function c511010103.desfilter(c,tp)
	return c:IsControler(1-tp) and c:GetAttack()<c:GetBaseAttack()
end
function c511010103.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511010103.desfilter,1,nil,tp) and Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511010103.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=eg:FilterSelect(tp,c511010103.desfilter,1,1,nil,tp)
	if #g>0 then
		Duel.HintSelection(g)
		if Duel.Destroy(g,REASON_EFFECT)>0 then
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end
end